import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

import 'package:mpm/ui/views/player/manage/manage_player_view_model.dart';
import 'package:mpm/ui/widgets/button.dart';

class ManagePlayerView extends ViewModelBuilderWidget<ManagePlayerViewModel>
{
	@override
  	bool get reactive => false;

  	@override
  	Widget builder(context, model, child)
	{
		return Scaffold(
			appBar: AppBar(
				title: Text(
					"Manage a player"
				),
			),
			body: Padding(
				padding: const EdgeInsets.all(8.0),
				child: Form(
					key: model.formKey,
					child: Column(
						children: <Widget>[
						],
					),
				),
			),
			floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
			floatingActionButton: Button(
				child: Text(
					"Manage a player"
				),
				color: Colors.green,
				onPressed: model.managePlayer
			),
		);
	}
  
	@override
	ManagePlayerViewModel viewModelBuilder(context)
	{
		return ManagePlayerViewModel();
	}
}