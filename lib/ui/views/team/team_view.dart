import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';

import 'package:mpm/services/database/models/team.dart';
import 'package:mpm/ui/views/team/team_view_model.dart';

class TeamView extends ViewModelBuilderWidget<TeamViewModel>
{
	@override
	bool get reactive => false;

	final Team team;

	TeamView({
		this.team
	});

  	@override
  	Widget builder(context, model, child)
	{
		return Scaffold(
			appBar: AppBar(
				title: Text(
					"MPM"
				),
			),
			body: Container()
		);
	}
  
	@override
	TeamViewModel viewModelBuilder(context)
	{
		return TeamViewModel(
			team: team
		);
	}
}