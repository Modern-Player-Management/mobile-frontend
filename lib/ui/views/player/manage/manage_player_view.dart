import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';

import 'package:mpm/services/database/models/team.dart';
import 'package:mpm/ui/views/player/manage/manage_player_view_model.dart';
import 'package:mpm/ui/widgets/button.dart';

class ManagePlayerView extends ViewModelBuilderWidget<ManagePlayerViewModel>
{
	final Team team;

	ManagePlayerView({
		this.team
	});

	@override
  	bool get reactive => false;

  	@override
  	Widget builder(context, model, child)
	{
		return Scaffold(
			body: Container(),
			floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
			floatingActionButton: Button(
				child: Text(
					"Add a player"
				),
				color: Colors.green,
				onPressed: model.managePlayer
			),
		);
	}
  
	@override
	ManagePlayerViewModel viewModelBuilder(context)
	{
		return ManagePlayerViewModel(
			team: team
		);
	}
}

