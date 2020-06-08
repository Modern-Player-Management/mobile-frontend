import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';

import 'package:mpm/app/locator.dart';
import 'package:mpm/utils/utils.dart';

class HomeViewModel extends BaseViewModel
{
	final _teamManager = locator<TeamManager>();
	final _navigation = locator<NavigationService>();

	Future<void> onRefresh() async
	{
		await _teamManager.syncTeams();
		Future.delayed(Duration(seconds: 2));
	}

	void playerInfo()
	{
		_navigation.navigateTo(Routes.playerViewRoute);
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

class HomeTeamViewModel extends FutureViewModel<void>
{
	final _db = locator<AppDatabase>();
	final _navigation = locator<NavigationService>();
	final _storage = locator<SecureStorage>();

	final Team team;

	bool loaded = false;

	String url;
	Map<String, String> headers;

	HomeTeamViewModel({
		@required this.team
	})
	{
		url = "$serverUrl/api/files/${team.image}";
		headers = {
			"Authorization": "Bearer ${_storage.token}"
		};
	}

	@override
	Future<void> futureToRun() async
	{
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

		loaded = true;
	}

	void onTap()
	{
		_navigation.navigateTo(
			Routes.teamViewRoute,
			arguments: TeamViewArguments(
				team: team
			)
		);
	}
}