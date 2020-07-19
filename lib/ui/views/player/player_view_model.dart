import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';

import 'package:mpm/app/locator.dart';
import 'package:validators/validators.dart';

class PlayerViewModel extends FutureViewModel<Player>
{
	final _storage = locator<SecureStorage>();
	final _session = locator<Session>();
	final _playerDao = locator<AppDatabase>().playerDao;

	final String playerId;
	String passwordError;

	PlayerViewModel({
		@required this.playerId
	});

	@override
	Future<Player> futureToRun() => _playerDao.get(playerId);

	void disconnect()
	{
		_session.disconnect();
	}

	bool get hasImage => data?.image != null;

	bool get isProfil => data?.id == _storage.player;

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

	void updateInformation()
	{
		
	}

	void passwordChanged(String str)
	{
		passwordError = passwordValidator(str);
		data.password = str;
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
		if(str != data.password)
		{
			return "Password confirmation and password must match";
		}
		return null;
	}

	void updatePassword()
	{
		
	}

	void changeImage()
	{

	}
}