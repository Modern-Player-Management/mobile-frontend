import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';

import 'package:mpm/services/database/models/player.dart';
import 'package:mpm/ui/views/player/player_view_model.dart';
import 'package:mpm/ui/widgets/circle_avatar_image.dart';

class PlayerView extends ViewModelBuilderWidget<PlayerViewModel>
{
	@override
	bool get reactive => false;

	final Player player;

	PlayerView({
		this.player
	});

  	@override
  	Widget builder(context, model, child)
	{
		return Scaffold(
			appBar: AppBar(
				title: Text(
					"MPM"
				),
			),
			body: Padding(
				padding: const EdgeInsets.all(8.0),
				child: Column(
					children: <Widget>[
						_Header()
					],
				),
			)
		);
	}
  
	@override
	PlayerViewModel viewModelBuilder(context)
	{
		return PlayerViewModel(
			player: player
		);
	}
}

class _Header extends ViewModelWidget<PlayerViewModel>
{
	@override
	Widget build(context, model)
	{
		return Row(
			children: <Widget>[
				CircleAvatarImage(
					url: model.url,
					headers: model.headers,
					hasImage: model.hasImage,
					icon: Icons.person,
				)
			],
		);
	}
}