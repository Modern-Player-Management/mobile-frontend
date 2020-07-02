import 'package:flutter/material.dart';

import 'package:chopper/chopper.dart';
import 'package:injectable/injectable.dart';

import 'package:mpm/app/locator.dart';


@injectable
class TeamManager
{
	final _api = locator<TeamApi>();
	final _teamDao = locator<AppDatabase>().teamDao;
	final _playerDao = locator<AppDatabase>().playerDao;

	final _storage = locator<SecureStorage>();
	final _uuid = locator<Uuid>();

	PlayerManager _playerManager;

	bool Function(Response) validResponse;

	TeamManager({
		@required @factoryParam Function validResponse
	}) : this.validResponse = validResponse
	{
		_playerManager = locator<PlayerManager>(param1: validResponse);
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
			var res = await _api.getTeams();
			if(validResponse(res))
			{
				List<Team> teams = res.body;

				var savedTeams = await _teamDao.getSavedTeams(_storage.player);
				var teamsKey = [
					for(var team in savedTeams)
						team.id
				];

				for(var team in teams)
				{
					team.player = _storage.player;
					team.saved = true;
					await _teamDao.insertModel(team);

					int index = teamsKey.indexOf(team.id);
					if(index != -1)
					{
						savedTeams.removeAt(index);
						teamsKey.removeAt(index);
					}

					await _playerManager.syncPlayers(team);
				}

				for(var team in savedTeams) 
				{
					await _teamDao.deleteModel(team);
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
		for(var team in await _teamDao.getUnsavedTeams(_storage.player))
		{
			try
			{
				if(team.updated)
				{
					var res = await _api.updateTeam(team.id, team);
					if(validResponse(res))
					{
						team.saved = true;
						await _teamDao.updateModel(team);
					}
				}
				else
				{
					var res = await _api.createTeam(team);
					if(validResponse(res))
					{
						team.updated = false;
						team.saved = true;
						await _teamDao.updateModel(team);
					}
				}
			}
			catch(e)
			{
				print("_saveUnsavedTeams: $e");
				return;
			}
		}
	}

	void _deleteUndeletedTeams() async
	{
		for(var team in await _teamDao.getUndeletedTeams(_storage.player))
		{
			try
			{
				var res = await _api.deleteTeam(team.id);
				if(validResponse(res))
				{
					await _teamDao.deleteModel(team);
				}
			}
			catch(e)
			{
				print("_deleteUndeletedTeams: $e");
				return;
			}
		}
	}

	Stream<List<Team>> getTeams() async *
	{
		await for(var teams in _teamDao.getTeams(_storage.player))
		{
			for(var team in teams)
			{
				team.manager = await _playerDao.getPlayer(team.managerId);
				team.players = await _playerDao.getAllPlayers(team.id, team.managerId);
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
			var response = await _api.createTeam(team);
			if(validResponse(response))
			{
				await _teamDao.updateTeamId(team.id, response.body.id, 1);
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
		team.updated = true;
		await _teamDao.updateModel(team);

		try
		{
			var response = await _api.updateTeam(team.id, team);
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
			var response = await _api.deleteTeam(team.id);
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