import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';

import 'package:mpm/services/database/models/team.dart';
import 'package:mpm/ui/views/team/team_view_model.dart';
import 'package:mpm/ui/views/team/event/team_events_view.dart';
import 'package:mpm/ui/views/team/player/team_players_view.dart';
import 'package:mpm/ui/views/team/game/team_games_view.dart';
import 'package:mpm/ui/widgets/circle_avatar_image.dart';

class TeamView extends ViewModelBuilderWidget<TeamViewModel>
{
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
					"${model.team.name}"
				),
			),
			body: Column(
				children: <Widget>[
					_Header(),
					Expanded(
						child: _Tabs(),
					)
				],
			),
			bottomNavigationBar: _NavigationBar(),
			floatingActionButton: model.isManager && !model.isGameTab ?
			FloatingActionButton(
				child: Icon(
					Icons.add
				),
				onPressed: model.add,
			) : null
		);
	}
	@override
	TeamViewModel viewModelBuilder(context)
	{
		return TeamViewModel(
			context: context,
			team: team
		);
	}
}

class _NavigationBar extends ViewModelWidget<TeamViewModel>
{
	@override
	Widget build(context, model)
	{
		return FFNavigationBar(
			theme: FFNavigationBarTheme(),
			selectedIndex: model.selectedTab,
			onSelectTab: model.onSelectTab,
			items: [
				FFNavigationBarItem(
					iconData: Icons.calendar_today,
					label: 'Events',
				),
				FFNavigationBarItem(
					iconData: Icons.group,
					label: 'Players',
				),
				FFNavigationBarItem(
					iconData: Icons.games,
					label: 'Games',
				)
			],
		);
	}
}

class _Header extends ViewModelWidget<TeamViewModel>
{
	@override
	Widget build(context, model)
	{
		return Card(
			child: ListTile(
				leading: CircleAvatarImage(
					image: model.team.image,
				),
				title: Text(
					"${model.team.description}"
				),
				subtitle: Text(
					"Players: ${model.team.players.length}"
				),
				trailing: model.isManager ?
				Row(
					mainAxisSize: MainAxisSize.min,
					children: <Widget>[
						IconButton(
							icon: Icon(
								Icons.edit,
								color: Colors.green,
							),
							onPressed: model.edit,
						),
						IconButton(
							icon: Icon(
								Icons.delete,
								color: Colors.red,
							),
							onPressed: model.delete,
						),
					],
				) : null,
			)
		);
	}
}

class _Tabs extends ViewModelWidget<TeamViewModel>
{
	@override
	Widget build(context, model)
	{
		return PageView(
			controller: model.controller,
			onPageChanged: model.onPageChanged,
			children: <Widget>[
				TeamEventsView(),
				TeamPlayersView(),
				TeamGamesView()
			],
		);
	}
}