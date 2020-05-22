// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:mpm/ui/views/splash/splash_view.dart';
import 'package:mpm/ui/views/auth/auth_view.dart';
import 'package:mpm/ui/views/auth/login/login_view.dart';
import 'package:mpm/ui/views/auth/register/register_view.dart';
import 'package:mpm/ui/views/home/home_view.dart';
import 'package:mpm/ui/views/team/create_team/create_team_view.dart';

abstract class Routes {
  static const splashViewRoute = '/';
  static const authViewRoute = '/auth-view-route';
  static const loginViewRoute = '/login-view-route';
  static const registerViewRoute = '/register-view-route';
  static const homeViewRoute = '/home-view-route';
  static const createTeamViewRoute = '/create-team-view-route';
  static const all = {
    splashViewRoute,
    authViewRoute,
    loginViewRoute,
    registerViewRoute,
    homeViewRoute,
    createTeamViewRoute,
  };
}

class Router extends RouterBase {
  @override
  Set<String> get allRoutes => Routes.all;

  @Deprecated('call ExtendedNavigator.ofRouter<Router>() directly')
  static ExtendedNavigatorState get navigator =>
      ExtendedNavigator.ofRouter<Router>();

  @override
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashViewRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => SplashView(),
          settings: settings,
        );
      case Routes.authViewRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => AuthView(),
          settings: settings,
        );
      case Routes.loginViewRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => LoginView(),
          settings: settings,
        );
      case Routes.registerViewRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => RegisterView(),
          settings: settings,
        );
      case Routes.homeViewRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => HomeView(),
          settings: settings,
        );
      case Routes.createTeamViewRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => CreateTeamView(),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}
