import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';

import 'package:mpm/app/locator.dart';
import 'package:mpm/services/database/models/player.dart';

class LoginViewModel extends BaseViewModel
{
	final authApi = locator<AuthApi>();
	final storage = locator<SecureStorage>();
	final navigation = locator<NavigationService>();

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
		try
		{
			final res = await authApi.authenticate(player.username, player.password);
			if(res.isSuccessful)
			{
				storage.player = res.body['username'];
				storage.token = res.body['token'];

				navigation.replaceWith(Routes.homeViewRoute);
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