import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';

import 'package:mpm/services/database/models/player.dart';
import 'package:mpm/ui/views/player/player_view_model.dart';

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
			body: Container()
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