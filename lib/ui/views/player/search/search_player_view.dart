import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';

import 'package:mpm/services/database/models/team.dart';
import 'package:mpm/ui/views/player/search/search_player_view_model.dart';
import 'package:mpm/services/database/models/player.dart';
import 'package:mpm/ui/widgets/button.dart';

class SearchPlayerView extends ViewModelBuilderWidget<SearchPlayerViewModel>
{
	final Team team;

	SearchPlayerView({
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
					searchBarPadding: const EdgeInsets.only(top: 16),
					onSearch: model.onSearch,
					placeHolder: Center(
						child: Text(
							"Search for a player",
							style: Theme.of(context).textTheme.headline6,
							textAlign: TextAlign.center,
						),
					),
					hintText: "Player username",
					cancellationWidget: Icon(
						Icons.cancel,
						color: Colors.grey,
					),
					emptyWidget: Center(
						child: Icon(
							Icons.error,
							size: 64,
							color: Colors.red,
						),
					),
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
	SearchPlayerViewModel viewModelBuilder(context)
	{
		return SearchPlayerViewModel(
			team: team
		);
	}
}

