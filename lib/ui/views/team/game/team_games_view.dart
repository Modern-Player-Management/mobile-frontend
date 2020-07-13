import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';
import 'package:intl/intl.dart';

import 'package:mpm/ui/views/team/game/team_games_view_model.dart';

class TeamGamesView extends ViewModelBuilderWidget<TeamGamesViewModel>
{
	final _format = DateFormat.yMd('fr_FR').add_Hm();

  	@override
  	Widget builder(context, model, child)
	{
		return model.dataReady ?
		ListView.builder(
			physics: BouncingScrollPhysics(),
			itemCount: model.data.length,
			itemBuilder: (context, index) {
				var game = model.data[index];
				return Card(
					child: ListTile(
						title: Text(
							game.name
						),
						subtitle: Text(
							_format.format(DateTime.parse(game.date))
						),
						trailing: Icon(
							game.isWin ? Icons.check : Icons.clear,
							color: game.isWin ? Colors.green : Colors.red,
						),
					)
				);
			}
		) :
		Center(
			child: CircularProgressIndicator(),
		);
	}
	@override
	TeamGamesViewModel viewModelBuilder(context)
	{
		return TeamGamesViewModel(
			context: context,
		);
	}
}