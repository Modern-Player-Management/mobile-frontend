import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';

import 'package:mpm/app/locator.dart';

class HomeViewModel extends BaseViewModel
{
	final _teamManager = locator<TeamManager>();
	final _navigation = locator<NavigationService>();

	final BuildContext context;

	HomeViewModel({
		@required this.context
	});

	Future<void> onRefresh() async
	{
		await _teamManager.syncTeams();
		Future.delayed(Duration(seconds: 2));
	}

	void createTeam()
	{
		_navigation.navigateTo(Routes.createTeamViewRoute);
	}
}

class TeamsViewModel extends StreamViewModel<List<Team>>
{
	@override
	Stream<List<Team>> get stream => locator<TeamManager>().getTeams();
}

class TeamViewModel extends FutureViewModel<void>
{
	final _db = locator<AppDatabase>();

	final Team team;
	final List<Player> players = [];
	Player manager;

	bool loaded = false;

	TeamViewModel({
		@required this.team
	});

	@override
	Future<void> futureToRun() async
	{
		manager = await _db.playerDao.getPlayer(team.managerId);

		var teamPlayers = await _db.teamPlayerDao.getTeamPlayers(team.id);
		for(var teamPlayer in teamPlayers)
		{
			var player = await _db.playerDao.getPlayer(teamPlayer.playerId);
			players.add(player);
		}

		loaded = true;
	}
}