import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';
import 'package:validators/validators.dart';

import 'package:mpm/app/locator.dart';
import 'package:mpm/models/user.dart';

class RegisterViewModel extends BaseViewModel
{
	final authApi = locator<AuthApi>();
	final storage = locator<SecureStorage>();
	final formKey = GlobalKey<FormState>();

	final User user = User();
	String passwordError, requestError;

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
		user.password = str;
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
			return "At least one upercase letter is required";
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
		if(str != user.password)
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
			try
			{
				final res = await authApi.register(user.username, user.email, user.password);
				if(res.isSuccessful)
				{

				}
				else
				{
					requestError = res.error;
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