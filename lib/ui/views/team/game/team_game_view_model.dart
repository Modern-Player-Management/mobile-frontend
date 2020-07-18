import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';

import 'package:mpm/app/locator.dart';

class TeamGameViewModel extends FutureViewModel<List<PlayerStats>>
{
	final Game game;

	final _playerStatsDao = locator<AppDatabase>().playerStatsDao;

	TeamGameViewModel({
		@required this.game
	});

	@override
	Future<List<PlayerStats>> futureToRun() => _playerStatsDao.getList(game.id);
}