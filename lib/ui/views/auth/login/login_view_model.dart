import 'package:flutter/material.dart';
import 'package:mpm/utils/dialogs.dart';

import 'package:stacked/stacked.dart';

import 'package:mpm/app/locator.dart';
import 'package:mpm/services/database/models/player.dart';

class LoginViewModel extends BaseViewModel
{
	final _authApi = locator<AuthApi>();
	final _storage = locator<SecureStorage>();
	final _session = locator<Session>();
	final _navigation = locator<NavigationService>();

	final formKey = GlobalKey<FormState>();

	final BuildContext context;
	final Player player = Player();
	String requestError;

	LoginViewModel({
		@required this.context
	});

	String usernameValidator(String str)
	{
		if(str.isEmpty)
		{
			return "You must enter a username";
		}
		return null;
	}

	String passwordValidator(String str)
	{
		if(str.isEmpty)
		{
			return "You must enter a password";
		}

		return null;
	}

	void login() async
	{
		if(formKey.currentState.validate())
		{
			showLoadingDialog(context);
			formKey.currentState.save();
			try
			{
				final res = await _authApi.authenticate(player.username, player.password);
				if(res.isSuccessful)
				{
					_storage.player = res.body['id'];
					_storage.token = res.body['token'];

					_session.synchronize();
				}
				else
				{
					_navigation.back();
					requestError = "Invalid credentials";
					notifyListeners();
				}
			}
			catch(e)
			{
				_navigation.back();
				print("login: $e");
			}
		}
	}
}