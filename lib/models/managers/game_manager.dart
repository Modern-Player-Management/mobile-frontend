import 'package:flutter/material.dart';

import 'package:chopper/chopper.dart';
import 'package:injectable/injectable.dart';

import 'package:mpm/app/locator.dart';

@injectable
class GameManager
{
	final _teamApi = locator<TeamApi>();
	final _gameApi = locator<GameApi>();

	final _gameDao = locator<AppDatabase>().gameDao;
	final _teamGameDao = locator<AppDatabase>().teamGameDao;

	final _storage = locator<SecureStorage>();

	bool Function(Response) validResponse;

	GameManager({
		@required @factoryParam Function validResponse
	}) : this.validResponse = validResponse;

	void _checkValidResponse()
	{
		if(validResponse == null)
		{
			validResponse = locator<Session>().validResponse;
		}
	}

	Future<void> syncGames(Team team) async
	{
		if(_storage.token == null)
		{
			return;
		}

		_checkValidResponse();
		_deleteUndeletedGames(team);
	}

	void _deleteUndeletedGames(Team team) async
	{
		for(var teamGame in await _teamGameDao.getUndeleted(team.id))
		{
			Game game = await _gameDao.get(teamGame.gameId);

			try
			{
				var res = await _gameApi.deleteGame(game.id);
				if(validResponse(res))
				{
					await _gameDao.deleteModel(game);
				}
			}
			catch(e)
			{
				print("deleteUndeletedGames: $e");
				return;
			}
		}
	}
}