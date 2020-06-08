import 'dart:async';

import 'package:flutter/material.dart';

import 'package:bot_toast/bot_toast.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:dynamic_theme/dynamic_theme.dart';

import 'package:mpm/app/locator.dart';
import 'package:mpm/utils/colors.dart';

void main() async 
{
	WidgetsFlutterBinding.ensureInitialized();

	// configure 
	await configure();

	// run app
	runApp(App());
}

class App extends ViewModelBuilderWidget<AppModel> with WidgetsBindingObserver
{
	@override
	bool get reactive => false;

	final _model = AppModel();

	@override
	void didChangeAppLifecycleState(AppLifecycleState state) 
	{
		switch(state)
		{
			case AppLifecycleState.resumed: 
				_model.resume();
				break;
			case AppLifecycleState.paused:
				_model.pause();
				break;
			case AppLifecycleState.inactive:
				break;
			case AppLifecycleState.detached: 
				break;
			default: break;
		}
	}

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
		WidgetsBinding.instance.addObserver(this);
		return _model;
	}
}

class AppModel extends BaseViewModel
{
	final _connectivity = locator<Connectivity>();
	final _session = locator<Session>();

	StreamSubscription _subscription;

	AppModel()
	{
		resume();
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