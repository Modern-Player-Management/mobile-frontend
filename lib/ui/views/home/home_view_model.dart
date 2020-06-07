import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';

import 'package:mpm/app/locator.dart';

class HomeViewModel extends BaseViewModel
{
	final _session = locator<Session>();
	final _teamManager = locator<TeamManager>();
	final _navigation = locator<NavigationService>();

	Future<void> onRefresh() async
	{
		await _teamManager.syncTeams();
		Future.delayed(Duration(seconds: 2));
	}

	void disconnect()
	{
		_session.disconnect();
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
	final _fileApi = locator<FileApi>();

	final Team team;

	bool loaded = false;

	HomeTeamViewModel({
		@required this.team
	});

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

		var res = await _fileApi.getFile(team.image);
		if(res.isSuccessful)
		{
			team.imageUrl = res.body;
			print(res.body);
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