import 'package:chopper/chopper.dart';
import 'package:injectable/injectable.dart';

import 'package:mpm/app/locator.dart';

@lazySingleton
class Session
{
	final _storage = locator<SecureStorage>();
	final _navigation = locator<NavigationService>();

	TeamManager _teamManager;
	bool online = false;

	Session()
	{
		_teamManager = locator<TeamManager>(param1: validResponse);
	}

	bool validResponse(Response response)
	{
		if(response != null && response.statusCode == 401)
		{
			_storage.token = null;
			_storage.player = null;

			_navigation.pushNamedAndRemoveUntil(
				Routes.authViewRoute, 
				predicate: (route) => route == null
			);
		}

		return response != null && response.isSuccessful;
	}

	Future<void> synchronize() async
	{
		if(isAuth)
		{
			_teamManager.syncTeams();
			_navigation.pushNamedAndRemoveUntil(
				Routes.homeViewRoute, 
				predicate: (route) => route == null
			);
		}
		else
		{
			await Future.delayed(Duration(seconds: 2));
			_goToAuthView();
		}
	}

	void disconnect()
	{
		_storage.player = null;
		_storage.token = null;

		_goToAuthView();
	}

	void _goToAuthView()
	{
		_navigation.pushNamedAndRemoveUntil(
			Routes.authViewRoute, 
			predicate: (route) => route == null
		);
	}

	bool get isAuth => _storage.token != null;
}