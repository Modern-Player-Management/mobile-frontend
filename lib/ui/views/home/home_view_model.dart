import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';

import 'package:mpm/app/locator.dart';

class HomeViewModel extends BaseViewModel
{
	final BuildContext context;

	TeamManager _teamManager = locator<TeamManager>();

	HomeViewModel({
		@required this.context
	});

	Stream<List<Team>> get teams => _teamManager.getTeams();
}