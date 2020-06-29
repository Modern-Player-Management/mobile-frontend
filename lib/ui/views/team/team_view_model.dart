import 'package:flutter/material.dart';
import 'package:mpm/utils/dialogs.dart';

import 'package:stacked/stacked.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:mpm/app/locator.dart';

class TeamViewModel extends BaseViewModel
{
	final _teamManager = locator<TeamManager>();
	final _storage = locator<SecureStorage>();
	final _navigator = locator<NavigationService>();

	final BuildContext context;
	Team team;

	TeamViewModel({
		@required this.context,
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
		}
	}

	bool get isManager => team.managerId == _storage.player;
}

class TeamCalendarViewModel extends StreamViewModel<List<Event>>
{
	final _teamDao = locator<AppDatabase>().teamDao;

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
	get stream => _teamDao.getEvents(_teamViewModel.team);
}

class TeamPlayersViewModel extends StreamViewModel<List<Player>>
{
	final _playerManager = locator<PlayerManager>();

	final _teamDao = locator<AppDatabase>().teamDao;
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
	get stream => _teamDao.getPlayers(_teamViewModel.team);

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