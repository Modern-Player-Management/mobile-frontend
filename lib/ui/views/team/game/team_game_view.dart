import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';
import 'package:intl/intl.dart';

import 'package:mpm/services/database/models/game.dart';
import 'package:mpm/ui/views/team/game/team_game_view_model.dart';

class TeamGameView extends ViewModelBuilderWidget<TeamGameViewModel>
{
	final Game game;

	TeamGameView({
		@required this.game
	});

	@override
	bool get reactive => false;

  	@override
  	Widget builder(context, model, child)
	{
		return Scaffold(
			appBar: AppBar(
				title: Text(
					model.game.name
				),
			),
			body: Column(
				children: <Widget>[
					_Header(),
					Expanded(
						child: _PlayersStats(),
					)
				],
			),
		);
	}

	@override
	TeamGameViewModel viewModelBuilder(context)
	{
		return TeamGameViewModel(
			game: game
		);
	}
}

class _Header extends ViewModelWidget<TeamGameViewModel>
{
	final _format = DateFormat.yMd('fr_FR').add_Hm();

	@override
	bool get reactive => false;

	@override
	Widget build(context, model)
	{
		return Card(
			child: Padding(
				padding: const EdgeInsets.all(8.0),
				child: ListTile(
					leading: Icon(
						Icons.calendar_today
					),
					title: Text(
						_format.format(DateTime.parse(model.game.date))
					),
					trailing: Icon(
						model.game.isWin ? Icons.check : Icons.clear,
						color: model.game.isWin ? Colors.green : Colors.red,
					),
				),
			),
		);
	}
}

class _PlayersStats extends ViewModelWidget<TeamGameViewModel>
{
	@override
	Widget build(context, model)
	{
		return model.dataReady ?
		ListView.builder(
			physics: BouncingScrollPhysics(),
			itemCount: model.data.length,
			itemBuilder: (context, index){
				var playerStats = model.data[index];
				return Card(
					child: Column(
						mainAxisSize: MainAxisSize.min,
						crossAxisAlignment: CrossAxisAlignment.start,
						children: <Widget>[
							ListTile(
								leading: Icon(
									Icons.person
								),
								title: Text(
									playerStats.player
								),
								trailing: Text(
									"${playerStats.score}"
								),
							),
							_StatsWidget(
								left: "Goals: ${playerStats.goals}",
								right: "GoalShots: ${playerStats.goalShots}",
							),
							_StatsWidget(
								left: "Shots: ${playerStats.shots}",
								right: "Saves: ${playerStats.saves}",
							),
							_StatsWidget(
								left: "Assists: ${playerStats.assists}",
								right: "",
							),
						],
					),
				);
			},
		) :
		Center(
			child: CircularProgressIndicator(),
		);
	}
}

class _StatsWidget extends StatelessWidget
{
	final String left;
	final String right;

	_StatsWidget({
		@required this.left,
		@required this.right
	});

	@override
	Widget build(context)
	{
		return Padding(
			padding: const EdgeInsets.all(8.0),
			child: Row(
				children: <Widget>[
					Text(
						left,
						style: Theme.of(context).textTheme.subtitle2,
					),
					SizedBox(width: 32),
					Text(
						right,
						style: Theme.of(context).textTheme.subtitle2,
					)
				],
			),
		);
	}
}