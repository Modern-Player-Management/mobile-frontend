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
	final _teamPlayerDao = locator<AppDatabase>().teamPlayerDao;

	final _storage = locator<SecureStorage>();
	final _uuid = locator<Uuid>();

	final bool Function(Response) validResponse;

	TeamManager({
		@required @factoryParam Function validResponse
	}) : this.validResponse = validResponse;

	Future<void> syncTeams() async
	{
		List<Team> teams = [];

		try
		{
			var res = await _api.getTeams();
			if(validResponse(res))
			{
				teams = res.body;
			}
			else
			{
				return;
			}
		}
		catch(e)
		{
			return;
		}

		var savedTeams = await _teamDao.getSavedTeams(_storage.player);
		var teamsKey = [
			for(var team in savedTeams)
				team.id
		];

		for(var team in teams)
		{
			team.player = _storage.player;
			team.save = true;
			_teamDao.insertTeam(team);

			int index = teamsKey.indexOf(team.id);
			if(index != -1)
			{
				savedTeams.removeAt(index);
				teamsKey.removeAt(index);
			}
		}

		for(var team in savedTeams) 
		{
			_teamDao.deleteTeam(team);
		}
	}

	Stream<List<Team>> getTeams()
	{
		return _teamDao.getTeams(_storage.player);
	}

	Future<void> insertTeam(Team team, [bool add = true]) async
	{
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
		}
		catch(e) 
		{
			print(e);
		}
	}

	Future<void> updateTeam(Team team) async
	{
		await _teamDao.updateTeam(team);

		try
		{
			var response = await _api.updateTeam(team.id, team);
			if(validResponse(response)) 
			{
				team.save = true;
				await _teamDao.updateTeam(team);
			}
		}
		catch(e) 
		{
			print(e);
		}
	}

	Future<void> deleteTeam(Team team) async
	{
		team.delete = true;
		await _teamDao.updateTeam(team);

		try
		{
			var response = await _api.deleteTeam(team.id);
			if(validResponse(response))
			{
				await _teamDao.deleteTeam(team);
			}
		}
		catch(e) 
		{
			print(e);
		}
	}

	Future<void> addTeamPlayer(Team team, Player player) async
	{
		if(await _playerDao.getPlayer(player.id) == null)
		{
			_playerDao.insertPlayer(player);
		}

		var teamPlayer = TeamPlayer(
			teamId: team.id,
			playerId: player.id
		);

		await _teamPlayerDao.insertTeamPlayer(teamPlayer);

		try
		{
			var res = await _api.addTeamPlayer(team.id, player);
			if(validResponse(res))
			{
				teamPlayer.save = true;
				await _teamPlayerDao.updateTeamPlayer(teamPlayer);
			}
		}
		catch(e) 
		{
			print(e);
		}
	}

	Future<void> removeTeamPlayer(Team team, Player player) async
	{
		
	}
}