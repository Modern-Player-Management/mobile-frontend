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
		await _session.synchronize();
	}
}