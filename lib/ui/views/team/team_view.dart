import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';

import 'package:mpm/services/database/models/team.dart';
import 'package:mpm/ui/views/team/team_view_model.dart';
import 'package:mpm/ui/widgets/circle_avatar_image.dart';
import 'package:mpm/ui/widgets/icon_text.dart';

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
				child: Padding(
					padding: const EdgeInsets.all(8.0),
					child: Row(
						children: <Widget>[
							CircleAvatarImage(
								image: model.team.image,
							),
							SizedBox(
								width: 16,
							),
							Column(
								crossAxisAlignment: CrossAxisAlignment.start,
								children: <Widget>[
									IconText(
										icon: Icons.description,
										text: "${model.team.description}",
									),
									IconText(
										icon: Icons.group,
										text: "${model.team.players.length}",
									)
								],
							)
						],
					),
				),
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