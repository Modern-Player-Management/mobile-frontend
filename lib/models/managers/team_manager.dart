import 'package:flutter/material.dart';

import 'package:chopper/chopper.dart';
import 'package:injectable/injectable.dart';

import 'package:mpm/app/locator.dart';


@injectable
class TeamManager
{
	final _api = locator<TeamApi>();
	final _teamDao = locator<AppDatabase>().teamDao;

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
					team.save = true;
					await _teamDao.insertTeam(team);

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
					await _teamDao.deleteTeam(team);
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

	Stream<List<Team>> getTeams()
	{
		return _teamDao.getTeams(_storage.player);
	}

	Future<bool> insertTeam(Team team, [bool add = true]) async
	{
		_checkValidResponse();

		if(add) 
		{
			team.id = _uuid.v1();
			team.player = _storage.player;
			team.save = true;

			await _teamDao.insertTeam(team);
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
			print("insertTeam: $e");
			return false;
		}

		return true;
	}

	Future<bool> updateTeam(Team team) async
	{
		_checkValidResponse();

		await _teamDao.updateTeam(team);

		try
		{
			var response = await _api.updateTeam(team.id, team);
			if(validResponse(response)) 
			{
				team.save = true;
				await _teamDao.updateTeam(team);
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

	Future<bool> deleteTeam(Team team) async
	{
		_checkValidResponse();
		
		team.delete = true;
		await _teamDao.updateTeam(team);

		try
		{
			var response = await _api.deleteTeam(team.id);
			if(validResponse(response))
			{
				await _teamDao.deleteTeam(team);
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