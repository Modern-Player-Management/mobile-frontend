import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';

import 'package:mpm/app/locator.dart';
import 'package:mpm/utils/dialogs.dart';

class TeamViewModel extends BaseViewModel
{
	final _teamManager = locator<TeamManager>();
	final _storage = locator<SecureStorage>();
	final _navigation = locator<NavigationService>();

	final BuildContext context;
	Team team;

	int selectedTab = 0;
	final controller = PageController();

	TeamViewModel({
		@required this.context,
		@required this.team
	});

	void setPlayers(List<Player> players)
	{
		team.players = players;
		notifyListeners();
	}

	void onPageChanged(int index)
	{
		selectedTab = index;
		notifyListeners();
	}

	void onSelectTab(int index)
	{
		selectedTab = index;
		controller.animateToPage(
			index, 
			duration: Duration(milliseconds: 300), 
			curve: Curves.easeInOut
		);
		notifyListeners();
	}

	void add()
	{
		switch(selectedTab)
		{
			case 0: _addEvent(); break;
			case 1: _addPlayer(); break;
			case 2: break; // nothing todo for games
			default: break; // wut ?
		}
	}

	void _addEvent()
	{
		_navigation.navigateTo(
			Routes.manageEventView,
			arguments: ManageEventViewArguments(
				team: team
			)
		);
	}

	void _addPlayer()
	{
		_navigation.navigateTo(
			Routes.searchPlayerView,
			arguments: SearchPlayerViewArguments(
				team: team
			)
		);
	}

	void edit() async
	{
		var res = await _navigation.navigateTo(
			Routes.manageTeamView,
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

	void delete() async
	{
		var res = await showConfirmDialog(
			context, 
			"Delete team", 
			"Are you sure you want to delete this team ?"
		);

		if(res)
		{
			await _teamManager.delete(team);
			_navigation.back();
		}
	}

	bool get isManager => team.managerId == _storage.player;
	bool get isGameTab => selectedTab == 2;
}