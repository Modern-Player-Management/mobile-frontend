import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';

import 'package:mpm/app/locator.dart';

class HomeViewModel extends BaseViewModel
{
	final BuildContext context;

	TeamManager _teamManager;

	HomeViewModel({
		@required this.context
	})
	{
		_teamManager = locator<TeamManager>(param1: validResponse);
	}

	bool validResponse(Response response)
	{
		
	}
}