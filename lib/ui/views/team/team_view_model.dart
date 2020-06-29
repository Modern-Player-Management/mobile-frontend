import 'dart:async';

import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';

import 'package:mpm/app/locator.dart';

class TeamViewModel extends BaseViewModel
{
	final _storage = locator<SecureStorage>();
	final _navigator = locator<NavigationService>();

	Team team;

	TeamViewModel({
		@required this.team
	});

	void addPlayer()
	{
		_navigator.navigateTo(
			Routes.searchPlayerViewRoute,
			arguments: SearchPlayerViewArguments(
				team: team
			)
		);
	}

	void edit() async
	{
		var res = await _navigator.navigateTo(
			Routes.manageTeamViewRoute,
			arguments: ManageTeamViewArguments(
				team: team
			)
		);

		if(res != null)
		{
			team = res;
			notifyListeners();
		}
	}

	void delete()
	{

	}

	bool get isManager => team.managerId == _storage.player;
}

class TeamPlayersViewModel extends StreamViewModel<List<Player>>
{
	final _playerManager = locator<PlayerManager>();

	final _db = locator<AppDatabase>();
	final _navigation = locator<NavigationService>();

	final BuildContext context;
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

	void onPressed(Player player) async
	{
		final teamPlayer = TeamPlayer(
			teamId: _teamViewModel.team.id,
			playerId: player.id
		);

		var res = await _playerManager.removeTeamPlayer(teamPlayer);
	}

	void onTap(Player player)
	{
		_navigation.navigateTo(
			Routes.playerViewRoute,
			arguments: PlayerViewArguments(
				player: player
			)
		);
	}

	bool get isManager => _teamViewModel.isManager;
}