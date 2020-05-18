import 'package:flutter/material.dart';

import 'package:bot_toast/bot_toast.dart';

import 'package:mpm/app/locator.dart';
import 'package:mpm/utils/colors.dart';

void main() async {

	WidgetsFlutterBinding.ensureInitialized();

	// configure 
	await configure();

	// run app
	runApp(MaterialApp(
		title: "MPM",
		builder: BotToastInit(),
		navigatorObservers: [BotToastNavigatorObserver()],
		theme: ThemeData(
			primaryColor: ThemeColors.primary,
			accentColor: ThemeColors.accent,
			primaryTextTheme: TextTheme(
				
			)
		),
		home: Scaffold(),
	));
}