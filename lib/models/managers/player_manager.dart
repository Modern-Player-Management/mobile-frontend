import 'package:flutter/material.dart';

import 'package:chopper/chopper.dart';
import 'package:injectable/injectable.dart';

import 'package:mpm/app/locator.dart';

@injectable
class PlayerManager
{
	final _teamApi = locator<TeamApi>();
	final _playerApi = locator<PlayerApi>();

	final _playerDao = locator<AppDatabase>().playerDao;
	final _teamPlayerDao = locator<AppDatabase>().teamPlayerDao;

	final _storage = locator<SecureStorage>();

	final bool Function(Response) validResponse;

	PlayerManager({
		@required @factoryParam Function validResponse
	}) : this.validResponse = validResponse;

	Future<void> syncPlayers(Team team) async
	{
		if(_storage.token == null)
		{
			return;
		}

		_playerDao.insertPlayer(team.manager);

		for(var player in team.players)
		{
			_playerDao.insertPlayer(player);
			if(player.id != team.manager.id)
			{
				var id = _teamPlayerDao.insertTeamPlayer(TeamPlayer(
					teamId: team.id,
					playerId: player.id,
					save: true
				));

				print("insert team player : ${team.id} / ${player.id} : $id");
			}
		}
	}

	Future<void> addTeamPlayer(Team team, Player player) async
	{
		_playerDao.insertPlayer(player);

		var teamPlayer = TeamPlayer(
			teamId: team.id,
			playerId: player.id
		);

		await _teamPlayerDao.insertTeamPlayer(teamPlayer);

		try
		{
			var res = await _teamApi.addTeamPlayer(team.id, player.id);
			if(validResponse(res))
			{
				teamPlayer.save = true;
				await _teamPlayerDao.updateTeamPlayer(teamPlayer);
			}
		}
		catch(e) 
		{
			print("addTeamPlayer: $e");
		}
	}

	Future<void> removeTeamPlayer(TeamPlayer teamPlayer) async
	{
		teamPlayer.delete = true;
		await _teamPlayerDao.updateTeamPlayer(teamPlayer);

		try
		{
			var res = await _teamApi.deleteTeamPlayer(teamPlayer.teamId, teamPlayer.playerId);
			if(validResponse(res))
			{
				await _teamPlayerDao.deleteTeamPlayer(teamPlayer);
			}
		}
		catch(e)
		{
			print("removeTeamPlayer: $e");
		}
	}
}