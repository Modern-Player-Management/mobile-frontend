import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';

import 'package:mpm/app/locator.dart';

class HomeViewModel extends BaseViewModel
{
	final _playerDao = locator<AppDatabase>().playerDao;
	final _storage = locator<SecureStorage>();
	final _teamManager = locator<TeamManager>();
	final _navigation = locator<NavigationService>();

	Future<void> onRefresh() async
	{
		await _teamManager.syncTeams();
		Future.delayed(Duration(seconds: 2));
	}

	void playerInfo() async
	{
		_navigation.navigateTo(
			Routes.playerViewRoute,
			arguments: PlayerViewArguments(
				player: await _playerDao.getPlayer(_storage.player)
			)
		);
	}

	void createTeam()
	{
		_navigation.navigateTo(Routes.manageTeamViewRoute);
	}
}

class HomeTeamsViewModel extends StreamViewModel<List<Team>>
{
	@override
	get stream => locator<TeamManager>().getTeams();
}

class HomeTeamViewModel extends FutureViewModel<bool>
{
	final _db = locator<AppDatabase>();
	final _navigation = locator<NavigationService>();

	final Team team;

	HomeTeamViewModel({
		@required this.team
	});

	@override
	Future<bool> futureToRun() async
	{
		team.players = [];
		team.manager = await _db.playerDao.getPlayer(team.managerId);

		var teamPlayers = await _db.teamPlayerDao.getAllTeamPlayers(team.id);
		for(var teamPlayer in teamPlayers)
		{
			var player = await _db.playerDao.getPlayer(teamPlayer.playerId);
			if(player.id != team.manager.id)
			{
				team.players.add(player);
			}
		}

		return true;
	}

	void onTap() async
	{
		await _navigation.navigateTo(
			Routes.teamViewRoute,
			arguments: TeamViewArguments(
				team: team,
			)
		);

		initialise();
	}
}