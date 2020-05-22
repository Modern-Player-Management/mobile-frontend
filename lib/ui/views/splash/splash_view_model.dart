import 'package:stacked/stacked.dart';

import 'package:mpm/app/locator.dart';

class SplashViewModel extends BaseViewModel
{
	final _session = locator<Session>();

	bool loading = true;

	SplashViewModel()
	{
		load();
	}

	void load() async
	{
		// remove this and wait for the end of the splashscreen
		await Future.delayed(Duration(seconds: 2));
		await _session.synchronize();
	}
}