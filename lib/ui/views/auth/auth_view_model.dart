import 'package:stacked/stacked.dart';

import 'package:mpm/app/locator.dart';
import 'package:mpm/app/router.gr.dart';

class AuthViewModel extends BaseViewModel
{
	final navigation = locator<NavigationService>();

	void toLogin()
	{
		navigation.navigateTo(Routes.loginViewRoute);
	}

	void toRegister()
	{
		navigation.navigateTo(Routes.registerViewRoute);
	}
}