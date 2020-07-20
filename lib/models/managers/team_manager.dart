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

		await _saveUnsavedTeams();
		await _deleteUndeletedTeams();

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
					var res = await _teamApi.getTeam(team.id);
					team = res.body;

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

	Future<void> _saveUnsavedTeams() async
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
						await _teamDao.deleteModel(team);

						team.id = res.body.id;
						team.create = false;
						team.saved = true;
						await _teamDao.insertModel(team);
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

	Future<void> _deleteUndeletedTeams() async
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
			}

			yield teams;
		}
	}

	Future<bool> insert(Team team) async
	{
		_checkValidResponse();

		team.id = _uuid.v1();
		team.player = _storage.player;
		team.create = true;

		await _teamDao.insertModel(team);

		try
		{
			var response = await _teamApi.createTeam(team);
			if(validResponse(response))
			{
				await _teamDao.deleteModel(team);

				team.id = response.body.id;
				team.saved = true;
				team.create = false;
				await _teamDao.insertModel(team);

				return true;
			}
		}
		catch(e) 
		{
			print("insertTeam: $e");
		}

		return false;
	}

	Future<bool> update(Team team) async
	{
		_checkValidResponse();
		
		team.saved = false;
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
			print("updateTeam: $e");
			return false;
		}

		return true;
	}

	Future<bool> delete(Team team) async
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
			print("deleteTeam: $e");
			return false;
		}

		return true;
	}
}