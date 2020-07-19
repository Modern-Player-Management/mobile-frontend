import 'package:flutter/material.dart';

import 'package:mpm/services/database/models/team.dart';
import 'package:mpm/ui/widgets/circle_avatar_image.dart';

class TeamWidget extends StatelessWidget
{
	final Team team;
	final Function(Team team) onTap;

	TeamWidget({
		@required this.team,
		@required this.onTap
	});

	@override
	Widget build(context)
	{
		return Hero(
			key: UniqueKey(),
			tag: team.id,
			child: Card(
				child: ListTile(
					leading: CircleAvatarImage(
						image: team.image,
					),
					title: Text(
						"${team.name}"
					),
					subtitle: Text(
						"Manager : ${team.manager?.username}"
					),
					onTap: () => onTap(team),
				),
			),
		);
	}
}