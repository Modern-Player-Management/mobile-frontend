import 'dart:async';

import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';

import 'package:mpm/app/locator.dart';

class TeamViewModel extends BaseViewModel
{
	final Team team;
	final _navigator = locator<NavigationService>();

	TeamViewModel({
		@required this.team
	});

	void addPlayer()
	{
		_navigator.navigateTo(
			Routes.managePlayerViewRoute,
			arguments: ManagePlayerViewArguments(
				team: team
			)
		);
	}
}

class TeamPlayersViewModel extends StreamViewModel<List<Player>>
{
	final BuildContext context;
	final _db = locator<AppDatabase>();
	final _controller = StreamController<List<Player>>.broadcast();

	TeamViewModel _teamViewModel;

	TeamPlayersViewModel({
		@required this.context
	})
	{
		_teamViewModel = getParentViewModel<TeamViewModel>(context);

		_db.teamPlayerDao.getTeamPlayers(_teamViewModel.team.id).listen((teamPlayers) async {
			List<Player> players = [];
			for(var teamPlayer in teamPlayers)
			{
				var player = await _db.playerDao.getPlayer(teamPlayer.playerId);
				if(player.id != _teamViewModel.team.manager.id)
				{
					players.add(player);
				}
			}
			_controller.add(players);
		});
	}

	@override
	get stream => _controller.stream;
}