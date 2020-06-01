import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';

import 'package:mpm/app/locator.dart';

class PlayerViewModel extends BaseViewModel
{
	final Player player;

	PlayerViewModel({
		@required this.player
	});
}