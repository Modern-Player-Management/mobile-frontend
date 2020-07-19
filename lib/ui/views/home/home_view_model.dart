import 'package:stacked/stacked.dart';

import 'package:mpm/app/locator.dart';

class HomeViewModel extends BaseViewModel
{
	final _storage = locator<SecureStorage>();
	final _navigation = locator<NavigationService>();
	final _session = locator<Session>();

	Future<void> onRefresh() async
	{
		await _session.synchronize(redirect: false);
	}

	void playerInfo() async
	{
		_navigation.navigateTo(
			Routes.playerView,
			arguments: PlayerViewArguments(
				playerId: _storage.player
			)
		);
	}

	void createTeam()
	{
		_navigation.navigateTo(Routes.manageTeamView);
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
			Routes.teamView,
			arguments: TeamViewArguments(
				team: team,
			)
		);
	}
}