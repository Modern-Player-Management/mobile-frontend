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
			_navigator.replaceWith(Routes.authViewRoute);
		}
		else
		{
			_navigator.replaceWith(Routes.homeViewRoute);
		}
	}
}