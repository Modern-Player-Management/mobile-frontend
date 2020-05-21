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
			body: StreamBuilder(
				stream: model.teams,
				builder: (context, AsyncSnapshot<List<Team>> snapshot){
					if(snapshot.hasData)
					{
						var teams = snapshot.data;

						return ListView.builder(
							itemCount: teams.length,
							itemBuilder: (context, i){
								var team = teams[i];
								return Card(
									child: ListTile(
										title: Text(
											team.name
										),
										subtitle: Text(
											"Manager : ${team.manager?.username}"
										),
									),
								);
							},
						);
					}

					return Center(
						child: CircularProgressIndicator(),
					);
				},
			)
		);
	}
  
	@override
	HomeViewModel viewModelBuilder(context)
	{
		return HomeViewModel(
			context: context
		);
	}
}