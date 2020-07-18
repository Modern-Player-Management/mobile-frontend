import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';

import 'package:mpm/app/locator.dart';
import 'package:mpm/ui/views/team/team_view_model.dart';

class TeamGamesViewModel extends StreamViewModel<List<Game>>
{
	final BuildContext context;
	final _gameDao = locator<AppDatabase>().gameDao;
	final _navigation = locator<NavigationService>();

	TeamViewModel _teamViewModel;

	TeamGamesViewModel({
		@required this.context
	})
	{
		_teamViewModel = getParentViewModel<TeamViewModel>(context);
	}

	get stream => _gameDao.getStream(_teamViewModel.team.id);

	void onTap(Game game)
	{
		_navigation.navigateTo(
			Routes.teamGameView,
			arguments: TeamGameViewArguments(
				game: game
			)
		);
	}
}