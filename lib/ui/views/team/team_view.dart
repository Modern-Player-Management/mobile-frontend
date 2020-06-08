import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';

import 'package:mpm/services/database/models/team.dart';
import 'package:mpm/ui/views/team/team_view_model.dart';
import 'package:mpm/ui/widgets/circle_avatar_image.dart';

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
					_AppBar(),
					_TeamPlayersView()
				],
			),
			floatingActionButton: FloatingActionButton(
				child: Icon(
					Icons.add
				),
				onPressed: model.addPlayer,
			),
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

class _AppBar extends ViewModelWidget<TeamViewModel>
{
	@override
	Widget build(context, model)
	{
		return SliverAppBar(
			title: Text(
				"${model.team.name}"
			),
			floating: true,
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
								url: null,
								headers: null,
								hasImage: false,
								icon: Icons.person,
							),
							title: Text(
								player.username
							),
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