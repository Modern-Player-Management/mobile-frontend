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

		await _saveUnsavedPlayers(team);
		await _deleteUndeletedPlayers(team);

		await _playerDao.insertModel(team.manager);
		await _teamPlayerDao.insertModel(TeamPlayer(
			teamId: team.id,
			playerId: team.manager.id,
			saved: true
		));

		for(var player in team.players)
		{
			await _playerDao.insertModel(player);
			if(player.id != team.manager.id)
			{
				await _teamPlayerDao.insertModel(TeamPlayer(
					teamId: team.id,
					playerId: player.id,
					saved: true
				));
			}
		}
	}

	Future<void> _saveUnsavedPlayers(Team team) async
	{
		for(var teamPlayer in await _teamPlayerDao.getUnsaved(team.id))
		{
			try
			{
				var res = await _teamApi.addTeamPlayer(teamPlayer.teamId, teamPlayer.playerId);
				if(validResponse(res))
				{
					teamPlayer.saved = true;
					await _teamPlayerDao.updateModel(teamPlayer);
				}
			}
			catch(e)
			{
				print("saveUnsavedPlayers: $e");
				return;
			}
		}
	}

	Future<void> _deleteUndeletedPlayers(Team team) async
	{
		for(var teamPlayer in await _teamPlayerDao.getUndeleted(team.id))
		{
			try
			{
				var res = await _teamApi.deleteTeamPlayer(teamPlayer.teamId, teamPlayer.playerId);
				if(validResponse(res))
				{
					await _teamPlayerDao.deleteModel(teamPlayer);
				}
			}
			catch(e)
			{
				print("deleteUndeletedPlayers: $e");
				return;
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
		
		await _playerDao.insertModel(player);

		var teamPlayer = TeamPlayer(
			teamId: team.id,
			playerId: player.id,
			saved: false
		);

		await _teamPlayerDao.insertModel(teamPlayer);

		try
		{
			var res = await _teamApi.addTeamPlayer(team.id, player.id);
			if(validResponse(res))
			{
				teamPlayer.saved = true;
				await _teamPlayerDao.updateModel(teamPlayer);
				return true;
			}
		}
		catch(e) 
		{
			print("addTeamPlayer: $e");
		}

		return false;
	}

	Future<bool> removeTeamPlayer(TeamPlayer teamPlayer) async
	{
		_checkValidResponse();
		
		teamPlayer.deleted = true;
		await _teamPlayerDao.updateModel(teamPlayer);

		try
		{
			var res = await _teamApi.deleteTeamPlayer(teamPlayer.teamId, teamPlayer.playerId);
			if(validResponse(res))
			{
				await _teamPlayerDao.deleteModel(teamPlayer);
				return true;
			}
		}
		catch(e)
		{
			print("removeTeamPlayer: $e");
		}

		return false;
	}

	Future<bool> updatePlayerInformation(Player player) async
	{
		_checkValidResponse();

		var data = Player()
			..username = player.username
			..email = player.email;

		try
		{
			var response = await _playerApi.updatePlayer(player.id, data);
			if(validResponse(response))
			{
				await _playerDao.updateModel(player);
				return true;
			}
		}
		catch(e)
		{
			print("updatePlayerInformation: $e");
		}
		
		return false;
	}

	Future<bool> updatePlayerPassword(Player player) async
	{
		_checkValidResponse();

		var data = Player()..password = player.password;

		if(data.password != null)
		{
			try
			{
				var response = await _playerApi.updatePlayer(player.id, data);
				if(validResponse(response))
				{
					return true;
				}
			}
			catch(e)
			{
				print("updatePlayerPassword: $e");
			}
		}

		return false;
	}
}