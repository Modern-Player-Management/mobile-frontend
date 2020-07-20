import 'package:flutter/material.dart';
import 'package:mpm/utils/toast_factory.dart';

import 'package:stacked/stacked.dart';

import 'package:mpm/app/locator.dart';

class SearchPlayerViewModel extends BaseViewModel
{
	final _playerManager = locator<PlayerManager>();

	final _navigation = locator<NavigationService>();

	final BuildContext context;
	final Team team;

	SearchPlayerViewModel({
		@required this.context,
		@required this.team
	});

	Future<List<Player>> onSearch(String str) async => _playerManager.search(str);

	void addPlayer(Player player) async
	{
		var res = await _playerManager.addTeamPlayer(team, player);
		if(res)
		{
			_navigation.back();
			ToastFactory.show(
				context: context, 
				msg: "Player ${player.username} succesfully added",
				style: ToastStyle.success
			);
		}
		else
		{
			ToastFactory.show(
				context: context, 
				msg: "An error occured when adding a player to the team",
				style: ToastStyle.error
			);
		}
	}
}