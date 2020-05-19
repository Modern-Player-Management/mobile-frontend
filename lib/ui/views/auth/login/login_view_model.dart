import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';

import 'package:mpm/app/locator.dart';
import 'package:mpm/services/database/models/user.dart';

class LoginViewModel extends BaseViewModel
{
	final authApi = locator<AuthApi>();
	final storage = locator<SecureStorage>();
	final formKey = GlobalKey<FormState>();

	final User user = User();
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
			final res = await authApi.authenticate(user.username, user.password);
			if(res.isSuccessful)
			{
				storage.user = res.body['username'];
				storage.token = res.body['token'];
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