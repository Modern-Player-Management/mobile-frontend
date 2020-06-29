import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';

import 'package:mpm/ui/views/home/home_view_model.dart';
import 'package:mpm/ui/widgets/team_widget.dart';

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
		print(model.data);
		return model.dataReady ?
		ListView.builder(
			itemCount: model.data.length,
			itemBuilder: (context, i){
				return TeamWidget(
					team: model.data[i],
					onTap: model.onTap,
				);
			}
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