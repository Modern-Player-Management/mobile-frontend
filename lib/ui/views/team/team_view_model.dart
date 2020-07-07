import 'package:flutter/material.dart';
import 'package:mpm/utils/dialogs.dart';

import 'package:stacked/stacked.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:mpm/app/locator.dart';

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
			default: break; // wut ?
		}
	}

	void _addEvent()
	{
		_navigation.navigateTo(
			Routes.manageEventViewRoute,
			arguments: ManageEventViewArguments(
				team: team
			)
		);
	}

	void _addPlayer()
	{
		_navigation.navigateTo(
			Routes.searchPlayerViewRoute,
			arguments: SearchPlayerViewArguments(
				team: team
			)
		);
	}

	void edit() async
	{
		var res = await _navigation.navigateTo(
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

	void delete() async
	{
		var res = await showConfirmDialog(
			context, 
			"Delete team", 
			"Are you sure you want to delete this team ?"
		);

		if(res)
		{
			await _teamManager.deleteTeam(team);
			_navigation.back();
		}
	}

	bool get isManager => team.managerId == _storage.player;
}

class TeamCalendarViewModel extends StreamViewModel<List<Event>>
{
	final _eventDao = locator<AppDatabase>().eventDao;

	final BuildContext context;
	TeamViewModel _teamViewModel;

	final calendarController = CalendarController();

	TeamCalendarViewModel({
		@required this.context
	})
	{
		_teamViewModel = getParentViewModel<TeamViewModel>(context);
	}

	@override
	get stream async * {
		await for(var events in _eventDao.getStream(_teamViewModel.team.id))
		{
			print(events);
			yield events;
		}
	}
}

class TeamPlayersViewModel extends StreamViewModel<List<Player>>
{
	final _playerManager = locator<PlayerManager>();

	final _playerDao = locator<AppDatabase>().playerDao;
	final _navigation = locator<NavigationService>();

	final BuildContext context;

	TeamViewModel _teamViewModel;

	TeamPlayersViewModel({
		@required this.context
	})
	{
		_teamViewModel = getParentViewModel<TeamViewModel>(context);
	}

	@override
	get stream async * {
		await for(var players in _playerDao.getStream(_teamViewModel.team.id, _teamViewModel.team.managerId))
		{
			_teamViewModel.setPlayers(players);
			yield players;
		}
	}

	void onPressed(Player player) async
	{
		final teamPlayer = TeamPlayer(
			teamId: _teamViewModel.team.id,
			playerId: player.id
		);

		await _playerManager.removeTeamPlayer(teamPlayer);
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