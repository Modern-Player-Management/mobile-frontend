import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';

import 'package:mpm/app/locator.dart';
import 'package:mpm/ui/views/team/team_view_model.dart';

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

	bool get isManager => _teamViewModel.isManager;
}