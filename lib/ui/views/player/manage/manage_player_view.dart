import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';

import 'package:mpm/services/database/models/team.dart';
import 'package:mpm/ui/views/player/manage/manage_player_view_model.dart';
import 'package:mpm/services/database/models/player.dart';
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
			body: Padding(
				padding: const EdgeInsets.all(8.0),
				child: SearchBar<Player>(
					searchBarPadding: EdgeInsets.only(top: 16),
					onSearch: model.onSearch,
					onItemFound: (player, index) {
						return ListTile(
							leading: CircleAvatar(
								child: Icon(
									Icons.person
								),
							),
							title: Text(
								player.username
							),
						);
					},
				),
			),
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

