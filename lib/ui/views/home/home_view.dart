import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';

import 'package:mpm/services/database/models/team.dart';
import 'package:mpm/ui/views/home/home_view_model.dart';
import 'package:mpm/ui/widgets/circle_avatar_image.dart';

class HomeView extends ViewModelBuilderWidget<HomeViewModel>
{
	@override
  	bool get reactive => false;

  	@override
  	Widget builder(context, model, child)
	{
		return Scaffold(
			appBar: AppBar(
				title: Text(
					"MPM"
				),
				actions: <Widget>[
					IconButton(
						icon: Icon(
							Icons.person
						),
						onPressed: model.playerInfo,
					)
				],
			),
			body: RefreshIndicator(
				onRefresh: model.onRefresh,
				child: _TeamsView(),
			),
			floatingActionButton: FloatingActionButton(
				child: Icon(
					Icons.add
				),
				onPressed: model.createTeam,
			),
		);
	}
  
	@override
	HomeViewModel viewModelBuilder(context)
	{
		return HomeViewModel();
	}
}

class _TeamsView extends ViewModelBuilderWidget<HomeTeamsViewModel>
{
	@override
	Widget builder(context, model, child)
	{
		return model.isBusy ?
		Center(
			child: CircularProgressIndicator(),
		) :
		ListView.builder(
			itemCount: model.data.length,
			itemBuilder: (context, i) => _TeamView(team: model.data[i]),
		);
	}

	@override
	HomeTeamsViewModel viewModelBuilder(context)
	{
		return HomeTeamsViewModel();
	}
}

class _TeamView extends ViewModelBuilderWidget<HomeTeamViewModel>
{
	final Team team;

	_TeamView({
		@required this.team
	});

	@override
	Widget builder(context, model, child)
	{
		return Card(
			child: ListTile(
				leading: CircleAvatarImage(
					url: model.url,
					headers: model.headers,
					hasImage: model.hasImage,
				),
				title: Text(
					team.name
				),
				subtitle: model.loaded ?
				Text(
					"Manager : ${model.team.manager.username}"
				) : null,
				trailing: model.loaded ?
				Text(
					"Players : ${model.team.players.length}"
				) : null,
				onTap: model.onTap,
			),
		);
	}

	@override
	HomeTeamViewModel viewModelBuilder(context)
	{
		return HomeTeamViewModel(
			team: team
		);
	}
}