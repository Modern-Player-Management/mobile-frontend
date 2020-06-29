import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';

import 'package:mpm/services/database/models/team.dart';
import 'package:mpm/ui/views/team/team_view_model.dart';
import 'package:mpm/ui/widgets/circle_avatar_image.dart';
import 'package:mpm/ui/widgets/icon_text.dart';

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
			body: CustomScrollView(
				slivers: <Widget>[
					SliverAppBar(
						title: Text(
							"${model.team.name}"
						),
						floating: true,
					),
					_Header(),
					_TeamPlayersView()
				],
			),
			floatingActionButton: model.isManager ?
			FloatingActionButton(
				child: Icon(
					Icons.add
				),
				onPressed: model.addPlayer,
			) : null
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

class _Header extends ViewModelWidget<TeamViewModel>
{
	@override
	Widget build(context, model)
	{
		return SliverToBoxAdapter(
			child: Card(
				child: ListTile(
					leading: CircleAvatarImage(
						image: model.team.image,
					),
					title: Text(
						model.team.description
					),
					subtitle: Text(
						"Players: ${model.team.players.length}"
					),
					trailing: Row(
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
					),
				)
			),
		);
	}
}

class _TeamPlayersView extends ViewModelBuilderWidget<TeamPlayersViewModel>
{
	@override
	Widget builder(context, model, child)
	{
		return model.dataReady ?
		SliverList(
			delegate: SliverChildBuilderDelegate(
				(context, index) {
					var player = model.data[index];
					return Card(
						child: ListTile(
							leading: CircleAvatarImage(
								image: player.image,
								icon: Icons.person,
							),
							title: Text(
								player.username
							),
							trailing: model.isManager ?
							IconButton(
								icon: Icon(
									Icons.delete,
									color: Colors.red,
								),
								onPressed: () => model.onPressed(player),
							) : null,
							onTap: () => model.onTap(player),
						)
					);
				},
				childCount: model.data.length
			),
		) :
		SliverToBoxAdapter(
			child: Center(
				child: CircularProgressIndicator(),
			),
		);
	}

	@override
	TeamPlayersViewModel viewModelBuilder(context)
	{
		return TeamPlayersViewModel(
			context: context
		);
	}
}