import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';

import 'package:mpm/app/locator.dart';

class SearchPlayerViewModel extends BaseViewModel
{
	final _playerManager = locator<PlayerManager>();

	final _navigation = locator<NavigationService>();

	final Team team;

	SearchPlayerViewModel({
		@required this.team
	});

	Future<List<Player>> onSearch(String str) async => _playerManager.search(str);

	void addPlayer(Player player) async
	{
		var res = await _playerManager.addTeamPlayer(team, player);
		if(res)
		{
			_navigation.back();
		}
	}
}