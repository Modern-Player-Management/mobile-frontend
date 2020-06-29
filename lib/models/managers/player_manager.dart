import 'package:flutter/material.dart';

import 'package:chopper/chopper.dart';
import 'package:injectable/injectable.dart';

import 'package:mpm/app/locator.dart';
import 'package:mpm/utils/utils.dart';

@injectable
class PlayerManager
{
	final _teamApi = locator<TeamApi>();
	final _playerApi = locator<PlayerApi>();

	final _playerDao = locator<AppDatabase>().playerDao;
	final _teamPlayerDao = locator<AppDatabase>().teamPlayerDao;

	final _storage = locator<SecureStorage>();

	bool Function(Response) validResponse;

	PlayerManager({
		@required @factoryParam Function validResponse
	}) : this.validResponse = validResponse;

	void _checkValidResponse()
	{
		if(validResponse == null)
		{
			validResponse = locator<Session>().validResponse;
		}
	}

	Future<void> syncPlayers(Team team) async
	{
		if(_storage.token == null)
		{
			return;
		}

		_checkValidResponse();

		await _playerDao.insertPlayer(team.manager);
		await _teamPlayerDao.insertTeamPlayer(TeamPlayer(
			teamId: team.id,
			playerId: team.manager.id,
			save: true
		));

		for(var player in team.players)
		{
			await _playerDao.insertPlayer(player);
			if(player.id != team.manager.id)
			{
				await _teamPlayerDao.insertTeamPlayer(TeamPlayer(
					teamId: team.id,
					playerId: player.id,
					save: true
				));
			}
		}
	}

	Future<List<Player>> search(String str) async
	{
		if(str.length > minCharacters)
		{
			_checkValidResponse();

			try
			{
				var res = await _playerApi.searchPlayers(str);
				if(validResponse(res)) 
				{
					return res.body;
				}
			}
			catch(e)
			{
				print("Player manager, search player: $e");
			}
		}

		return [];
	}

	Future<bool> addTeamPlayer(Team team, Player player) async
	{
		_checkValidResponse();
		
		await _playerDao.insertPlayer(player);

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
			else
			{
				return false;
			}
		}
		catch(e) 
		{
			print("addTeamPlayer: $e");
		}

		return true;
	}

	Future<bool> removeTeamPlayer(TeamPlayer teamPlayer) async
	{
		_checkValidResponse();
		
		teamPlayer.delete = true;
		await _teamPlayerDao.updateTeamPlayer(teamPlayer);

		try
		{
			var res = await _teamApi.deleteTeamPlayer(teamPlayer.teamId, teamPlayer.playerId);
			if(validResponse(res))
			{
				await _teamPlayerDao.deleteTeamPlayer(teamPlayer);
			}
			else
			{
				return false;
			}
		}
		catch(e)
		{
			print("removeTeamPlayer: $e");
		}

		return true;
	}
}