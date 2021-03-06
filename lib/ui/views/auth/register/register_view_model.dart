import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';
import 'package:validators/validators.dart';

import 'package:mpm/app/locator.dart';
import 'package:mpm/services/database/models/player.dart';
import 'package:mpm/utils/dialogs.dart';

class RegisterViewModel extends BaseViewModel
{
	final _authApi = locator<AuthApi>();
	final _navigation = locator<NavigationService>();
	final formKey = GlobalKey<FormState>();

	final Player player = Player();
	String passwordError, requestError;
	final BuildContext context;

	RegisterViewModel({
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

	String emailValidator(String str)
	{
		if(str.isEmpty)
		{
			return "You must enter an email";
		}
		if(!isEmail(str))
		{
			return "You must enter a valid email";
		}
		return null;
	}

	void passwordChanged(String str)
	{
		passwordError = passwordValidator(str);
		player.password = str;
		notifyListeners();
	}

	String passwordValidator(String str)
	{
		if(str.isEmpty)
		{
			return "You must enter a password";
		}

		if(!RegExp(r"(?=.*[a-z])").hasMatch(str))
		{
			return "At least one lowercase letter is required";
		}
		if(!RegExp(r"(?=.*[A-Z])").hasMatch(str))
		{
			return "At least one uppercase letter is required";
		}
		if(!RegExp(r"(?=.*\d)").hasMatch(str))
		{
			return "At least one number is required";
		}
		if(!RegExp(r"^.{8,32}$").hasMatch(str))
		{
			return "Password length : 8-32 characters";
		}

		return null;
	}

	String passwordConfirmValidator(String str)
	{
		if(str.isEmpty)
		{
			return "You must confirm the password";
		}
		if(str != player.password)
		{
			return "Password confirmation and password must match";
		}
		return null;
	}

	void register() async
	{
		if(formKey.currentState.validate())
		{
			formKey.currentState.save();
			showLoadingDialog(context);
			try
			{
				final res = await _authApi.register(player.username, player.email, player.password);
				if(res.isSuccessful)
				{
					_navigation.replaceWith(Routes.loginView);
				}
				else
				{
					requestError = res.error;
					notifyListeners();
				}
			}
			catch(e)
			{
				print("register: $e");
			}

			_navigation.back();
		}
	}
}