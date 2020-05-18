import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';
import 'package:validators/validators.dart';

import 'package:mpm/app/locator.dart';

class AuthViewModel extends BaseViewModel
{
	final authApi = locator<AuthApi>();
	final storage = locator<SecureStorage>();
	final formKey = GlobalKey<FormState>();

	bool isLogin = true;

	String username, email, password, confirmPassword;
	String passwordError, requestError;

	String get switchText => isLogin ? "Don't have an account ?" : "Already have an account ?";
	String get switchTextButton => isLogin ? "Login" : "Signup";
	String get authText => isLogin ? "Login" : "Register";

	final BuildContext context;

	AuthViewModel({
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
		if(!isLogin)
		{
			passwordError = passwordValidator(str);
			notifyListeners();
		}
		password = str;
	}

	String passwordValidator(String str)
	{
		if(str.isEmpty)
		{
			return "You must enter a password";
		}

		if(!isLogin)
		{
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
		}

		return null;
	}

	String passwordConfirmValidator(String str)
	{
		if(str.isEmpty)
		{
			return "You must confirm the password";
		}
		if(str != password)
		{
			return "Password confirmation and password must match";
		}
		return null;
	}

	void toggleLogin()
	{
		isLogin = !isLogin;
		formKey.currentState.reset();
		requestError = null;

		if(isLogin)
		{
			passwordError = null;
		}

		notifyListeners();
	}

	void auth()
	{
		if(formKey.currentState.validate())
		{
			FocusScope.of(context).requestFocus(FocusNode());
			if(isLogin)
			{
				_login();
			}
			else
			{
				_register();
			}
		}
	}

	void _register() async
	{
		try
		{
			final res = await authApi.register(username, email, password);
			if(res.isSuccessful)
			{
				username = null;
				confirmPassword = null;
				toggleLogin();
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

	void _login() async
	{
		try
		{
			final res = await authApi.authenticate(username, password);
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