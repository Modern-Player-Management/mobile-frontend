import 'package:flutter/material.dart';

import 'package:bot_toast/bot_toast.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:mpm/app/locator.dart';
import 'package:mpm/utils/colors.dart';

void main() async 
{
	WidgetsFlutterBinding.ensureInitialized();

	// configure 
	await configure();

	// run app
	runApp(MaterialApp(
		title: "Modern Player Management",
		builder: BotToastInit(),
		navigatorObservers: [BotToastNavigatorObserver()],
		theme: ThemeData(
			primaryColor: ThemeColors.primary,
			accentColor: ThemeColors.accent,
			primaryTextTheme: TextTheme(
				
			)
		),
		initialRoute: Routes.splashViewRoute,
		onGenerateRoute: Router().onGenerateRoute,
		navigatorKey: locator<NavigationService>().navigatorKey,
	));
}