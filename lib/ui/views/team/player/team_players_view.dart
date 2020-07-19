import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';

import 'package:mpm/ui/views/team/player/team_players_view_model.dart';
import 'package:mpm/ui/widgets/circle_avatar_image.dart';

class TeamPlayersView extends ViewModelBuilderWidget<TeamPlayersViewModel>
{
	@override
	Widget builder(context, model, child)
	{
		return model.dataReady ?
		ListView.builder(
			physics: BouncingScrollPhysics(),
			itemCount: model.data.length,
			itemBuilder: (context, index) {
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
						) : null
					)
				);
			}
		) :
		Center(
			child: CircularProgressIndicator(),
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