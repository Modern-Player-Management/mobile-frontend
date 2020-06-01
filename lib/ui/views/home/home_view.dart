import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'package:mpm/services/database/models/team.dart';
import 'package:mpm/ui/views/home/home_view_model.dart';

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
		return model.dataReady ?
		ListView.builder(
			itemCount: model.data.length,
			itemBuilder: (context, i) => _TeamView(team: model.data[i]),
		) : 
		Center(
			child: CircularProgressIndicator(),
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
				leading: CircleAvatar(
					child: Icon(
						Icons.group,
						size: 32,
					),
				),
				title: Text(
					team.name
				),
				subtitle: model.loaded ?
				Text(
					"Manager : ${model.manager.username}"
				) : null,
				trailing: model.loaded ?
				Text(
					"Players : ${model.players.length}"
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