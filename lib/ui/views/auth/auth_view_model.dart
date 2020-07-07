import 'package:stacked/stacked.dart';

import 'package:mpm/app/locator.dart';

class AuthViewModel extends BaseViewModel
{
	final navigation = locator<NavigationService>();

	void toLogin()
	{
		navigation.navigateTo(Routes.loginView);
	}

	void toRegister()
	{
		navigation.navigateTo(Routes.registerView);
	}
}