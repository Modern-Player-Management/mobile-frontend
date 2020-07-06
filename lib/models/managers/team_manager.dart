import 'package:flutter/material.dart';

import 'package:chopper/chopper.dart';
import 'package:injectable/injectable.dart';

import 'package:mpm/app/locator.dart';


@injectable
class TeamManager
{
	final _teamApi = locator<TeamApi>();
	final _teamDao = locator<AppDatabase>().teamDao;
	final _playerDao = locator<AppDatabase>().playerDao;

	final _storage = locator<SecureStorage>();
	final _uuid = locator<Uuid>();

	PlayerManager _playerManager;
	EventManager _eventManager;
	GameManager _gameManager;

	bool Function(Response) validResponse;

	TeamManager({
		@required @factoryParam Function validResponse
	}) : this.validResponse = validResponse
	{
		_playerManager = locator<PlayerManager>(param1: validResponse);
		_eventManager = locator<EventManager>(param1: validResponse);
		_gameManager = locator<GameManager>(param1: validResponse);
	}

	void _checkValidResponse()
	{
		if(validResponse == null)
		{
			validResponse = locator<Session>().validResponse;
		}
	}

	Future<bool> syncTeams() async
	{
		if(_storage.token == null)
		{
			return false;
		}

		_checkValidResponse();

		_saveUnsavedTeams();
		_deleteUndeletedTeams();

		try
		{
			var res = await _teamApi.getTeams();
			if(validResponse(res))
			{
				List<Team> teams = res.body;

				var models = await _teamDao.getSaved(_storage.player);
				var keys = [
					for(var el in models)
						el.id
				];

				for(var team in teams)
				{
					team.player = _storage.player;
					team.saved = true;
					await _teamDao.insertModel(team);

					int index = keys.indexOf(team.id);
					if(index != -1)
					{
						models.removeAt(index);
						keys.removeAt(index);
					}

					await _playerManager.syncPlayers(team);
					await _eventManager.syncEvents(team);
					await _gameManager.syncGames(team);
				}

				for(var model in models)
				{
					await _teamDao.deleteModel(model);
				}
			}
			else
			{
				return false;
			}
		}
		catch(e)
		{
			print("SyncTeams: $e");
			return false;
		}

		return true;
	}

	void _saveUnsavedTeams() async
	{
		for(var team in await _teamDao.getUnsaved(_storage.player))
		{
			try
			{
				if(team.create)
				{
					var res = await _teamApi.createTeam(team);
					if(validResponse(res))
					{
						var id = res.body.id;
						_teamDao.updateId(team.id, id);
						team.id = id;
						team.create = false;
						team.saved = true;
						await _teamDao.updateModel(team);
					}
				}
				else
				{
					var res = await _teamApi.updateTeam(team.id, team);
					if(validResponse(res))
					{
						team.saved = true;
						await _teamDao.updateModel(team);
					}
				}
			}
			catch(e)
			{
				print("saveUnsavedTeams: $e");
				return;
			}
		}
	}

	void _deleteUndeletedTeams() async
	{
		for(var team in await _teamDao.getUndeleted(_storage.player))
		{
			try
			{
				var res = await _teamApi.deleteTeam(team.id);
				if(validResponse(res))
				{
					await _teamDao.deleteModel(team);
				}
			}
			catch(e)
			{
				print("deleteUndeletedTeams: $e");
				return;
			}
		}
	}

	Stream<List<Team>> getTeams() async *
	{
		await for(var teams in _teamDao.getStream(_storage.player))
		{
			for(var team in teams)
			{
				team.manager = await _playerDao.get(team.managerId);
				team.players = await _playerDao.getList(team.id, team.managerId);
			}

			yield teams;
		}
	}

	Future<bool> insertTeam(Team team, [bool add = true]) async
	{
		_checkValidResponse();

		if(add) 
		{
			team.id = _uuid.v1();
			team.player = _storage.player;
			team.saved = false;

			await _teamDao.insertModel(team);
		}

		try
		{
			var response = await _teamApi.createTeam(team);
			if(validResponse(response))
			{
				var id = response.body.id;
				await _teamDao.updateId(team.id, id);

				team.id = id;
				team.saved = true;
				await _teamDao.updateModel(team);
			}
			else
			{
				return false;
			}
		}
		catch(e) 
		{
			print("insertModel: $e");
			return false;
		}

		return true;
	}

	Future<bool> updateTeam(Team team) async
	{
		_checkValidResponse();
		
		team.saved = false;
		team.create = true;
		await _teamDao.updateModel(team);

		try
		{
			var response = await _teamApi.updateTeam(team.id, team);
			if(validResponse(response))
			{
				team.saved = true;
				await _teamDao.updateModel(team);
			}
			else
			{
				return false;
			}
		}
		catch(e) 
		{
			print("updateModel: $e");
			return false;
		}

		return true;
	}

	Future<bool> deleteTeam(Team team) async
	{
		_checkValidResponse();
		
		team.deleted = true;
		await _teamDao.updateModel(team);

		try
		{
			var response = await _teamApi.deleteTeam(team.id);
			if(validResponse(response))
			{
				await _teamDao.deleteModel(team);
			}
			else
			{
				return false;
			}
		}
		catch(e) 
		{
			print("deleteModel: $e");
			return false;
		}

		return true;
	}
}