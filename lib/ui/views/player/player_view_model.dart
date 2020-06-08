import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';

import 'package:mpm/app/locator.dart';
import 'package:mpm/utils/utils.dart';

class PlayerViewModel extends BaseViewModel
{
	final _storage = locator<SecureStorage>();

	final Player player;

	String url;
	Map<String, String> headers;

	PlayerViewModel({
		@required this.player
	})
	{
		url = "$serverUrl/api/files/${player.image}";
		headers = {
			"Authorization": "Bearer ${_storage.token}"
		};
	}

	bool get hasImage => player?.image != null;
}