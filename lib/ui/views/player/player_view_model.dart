import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';

import 'package:mpm/app/locator.dart';

class PlayerViewModel extends BaseViewModel
{
	final _storage = locator<SecureStorage>();
	final _session = locator<Session>();

	final Player player;

	PlayerViewModel({
		@required this.player
	});

	void disconnect()
	{
		_session.disconnect();
	}

	bool get hasImage => player?.image != null;

	bool get isProfil => player.id == _storage.player;
}