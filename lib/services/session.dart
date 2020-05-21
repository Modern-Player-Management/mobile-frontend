import 'package:chopper/chopper.dart';
import 'package:injectable/injectable.dart';

import 'package:mpm/app/locator.dart';

@lazySingleton
class Session
{
	final _storage = locator<SecureStorage>();
	final _navigation = locator<NavigationService>();

	TeamManager _teamManager;
	bool redirect = false;

	Session()
	{
		_teamManager = locator<TeamManager>(param1: _validResponse);
	}

	bool _validResponse(Response response)
	{
		if(response != null && response.statusCode == 401)
		{
			_storage.token = null;
			_storage.player = null;

			if(redirect) 
			{
				_navigation.clearStackAndShow(Routes.authViewRoute);
			}
		}

		return response != null && response.isSuccessful;
	}

	Future<void> synchronize() async
	{
		await _teamManager.syncTeams();
	}
}