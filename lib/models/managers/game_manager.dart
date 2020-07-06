import 'package:flutter/material.dart';

import 'package:chopper/chopper.dart';
import 'package:injectable/injectable.dart';

import 'package:mpm/app/locator.dart';

@injectable
class GameManager
{
	final _gameApi = locator<GameApi>();

	final _gameDao = locator<AppDatabase>().gameDao;

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

		var models = await _gameDao.getSaved(team.id);
		var keys = [
			for(var el in models)
				el.id
		];

		for(var game in team.games)
		{
			game.teamId = team.id;
			await _gameDao.insertModel(game);

			int index = keys.indexOf(game.id);
			if(index != -1)
			{
				models.removeAt(index);
				keys.removeAt(index);
			}
		}

		for(var model in models)
		{
			await _gameDao.deleteModel(model);
		}
	}

	void _deleteUndeletedGames(Team team) async
	{
		for(var game in await _gameDao.getUndeleted(team.id))
		{
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