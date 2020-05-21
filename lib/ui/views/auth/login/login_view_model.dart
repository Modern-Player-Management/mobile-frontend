import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';

import 'package:mpm/app/locator.dart';
import 'package:mpm/services/database/models/player.dart';

class LoginViewModel extends BaseViewModel
{
	final _authApi = locator<AuthApi>();
	final _storage = locator<SecureStorage>();
	final _navigation = locator<NavigationService>();

	final formKey = GlobalKey<FormState>();

	final Player player = Player();
	String requestError;

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
			formKey.currentState.save();
			try
			{
				final res = await _authApi.authenticate(player.username, player.password);
				if(res.isSuccessful)
				{
					_storage.player = res.body['username'];
					_storage.token = res.body['token'];

					_navigation.pushNamedAndRemoveUntil(
						Routes.homeViewRoute, 
						predicate: (route) => route == null
					);
				}
				else
				{
					requestError = "Invalid credentials";
					notifyListeners();
				}
			}
			catch(e)
			{
				print(e);
			}
		}
	}
}