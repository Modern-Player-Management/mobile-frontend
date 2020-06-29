import 'dart:async';

import 'package:flutter/material.dart';

import 'package:bot_toast/bot_toast.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:mpm/app/locator.dart';
import 'package:mpm/utils/colors.dart';

void main() async 
{
	WidgetsFlutterBinding.ensureInitialized();

	// configure 
	await configure();

	await initializeDateFormatting();

	// run app
	runApp(App());
}

class App extends ViewModelBuilderWidget<AppModel>
{
	@override
	bool get reactive => false;

  	@override
	Widget builder(context, model, child)
	{
		return DynamicTheme(
			defaultBrightness: Brightness.light,
			data: (brightness) {
				return ThemeData(
					primaryColor: ThemeColors.primary,
					accentColor: ThemeColors.accent,
				);
			},
			themedWidgetBuilder: (context, theme) {
				return MaterialApp(
					title: "Modern Player Management",
					builder: BotToastInit(),
					navigatorObservers: [BotToastNavigatorObserver()],
					theme: theme,
					initialRoute: Routes.splashViewRoute,
					onGenerateRoute: Router().onGenerateRoute,
					navigatorKey: locator<NavigationService>().navigatorKey,
				);
			},
		);
	}
  
	@override
	AppModel viewModelBuilder(context) 
	{
		var model = AppModel();
		WidgetsBinding.instance.addObserver(model);
		return model;
	}
}

class AppModel extends BaseViewModel with WidgetsBindingObserver
{
	final _connectivity = locator<Connectivity>();
	final _session = locator<Session>();

	StreamSubscription _subscription;

	AppModel()
	{
		resume();
	}

	@override
	void didChangeAppLifecycleState(AppLifecycleState state) 
	{
		switch(state)
		{
			case AppLifecycleState.resumed: 
				resume();
				break;
			case AppLifecycleState.paused:
				pause();
				break;
			case AppLifecycleState.inactive:
				break;
			case AppLifecycleState.detached: 
				break;
			default: break;
		}
	}

	void _onConnectivityChanged(ConnectivityResult result)
	{
		switch(result)
		{
			case ConnectivityResult.mobile:
			case ConnectivityResult.wifi: 
				_session.online = true;
				break;
			case ConnectivityResult.none:
			default: 
				_session.online = false;
				break;
		}
	}

	void pause()
	{
		_subscription.cancel();
	}

	void resume() async
	{
		_onConnectivityChanged(await _connectivity.checkConnectivity());
		_subscription = _connectivity.onConnectivityChanged.listen(_onConnectivityChanged);
	}

	@override
	void dispose()
	{ 
		pause();
		super.dispose();
	}
}