import 'package:chopper/chopper.dart';
import 'package:injectable/injectable.dart';

import 'package:mpm/app/locator.dart';

@lazySingleton
class Session
{
	final _storage = locator<SecureStorage>();
	final _navigation = locator<NavigationService>();
	final _playerApi = locator<PlayerApi>();
	final _playerDao = locator<AppDatabase>().playerDao;

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
				Routes.authView, 
				predicate: (route) => route == null
			);
		}

		return response != null && response.isSuccessful;
	}

	Future<void> synchronize({bool redirect = true}) async
	{
		if(isAuth)
		{
			if(redirect)
			{
				_navigation.pushNamedAndRemoveUntil(
					Routes.homeView, 
					predicate: (route) => route == null
				);
			}

			await _teamManager.syncTeams();
			await _syncPlayer();			
		}
		else
		{
			await Future.delayed(Duration(seconds: 1));
			if(redirect)
			{
				_goToAuthView();
			}
		}
	}

	Future<void> _syncPlayer() async
	{
		try
		{
			var response = await _playerApi.getProfile();
			if(validResponse(response))
			{
				final player = response.body;
				player.id = _storage.player;
				await _playerDao.insertModel(player);
			}
		}
		catch(e)
		{
			print("syncPlayer: $e");
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
			Routes.authView, 
			predicate: (route) => route == null
		);
	}

	bool get isAuth => _storage.token != null;
}