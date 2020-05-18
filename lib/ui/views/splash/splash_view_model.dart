import 'package:stacked/stacked.dart';

import 'package:mpm/app/router.gr.dart';
import 'package:mpm/app/locator.dart';

class SplashViewModel extends BaseViewModel
{
	final _navigator = locator<NavigationService>();
	final _storage = locator<SecureStorage>();

	void nextView()
	{
		if(_storage.token == null)
		{
			_navigator.navigateTo(Routes.authViewRoute);
		}
		else
		{
			_navigator.navigateTo(Routes.homeViewRoute);
		}
	}
}