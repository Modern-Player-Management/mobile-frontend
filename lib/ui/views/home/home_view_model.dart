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
	final _navigation = locator<NavigationService>();
	final _teamManager = locator<TeamManager>();

	@override
	get stream => _teamManager.getTeams();

	void onTap(Team team) async
	{
		await _navigation.navigateTo(
			Routes.teamViewRoute,
			arguments: TeamViewArguments(
				team: team,
			)
		);
	}
}