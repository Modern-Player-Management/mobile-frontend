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
import 'package:mpm/ui/views/team/team_view.dart';
import 'package:mpm/services/database/models/team.dart';
import 'package:mpm/ui/views/team/manage/manage_team_view.dart';
import 'package:mpm/ui/views/player/player_view.dart';
import 'package:mpm/services/database/models/player.dart';
import 'package:mpm/ui/views/player/search/search_player_view.dart';

abstract class Routes {
  static const splashViewRoute = '/';
  static const authViewRoute = '/auth-view-route';
  static const loginViewRoute = '/login-view-route';
  static const registerViewRoute = '/register-view-route';
  static const homeViewRoute = '/home-view-route';
  static const teamViewRoute = '/team-view-route';
  static const manageTeamViewRoute = '/manage-team-view-route';
  static const playerViewRoute = '/player-view-route';
  static const searchPlayerViewRoute = '/search-player-view-route';
  static const all = {
    splashViewRoute,
    authViewRoute,
    loginViewRoute,
    registerViewRoute,
    homeViewRoute,
    teamViewRoute,
    manageTeamViewRoute,
    playerViewRoute,
    searchPlayerViewRoute,
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
    final args = settings.arguments;
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
      case Routes.teamViewRoute:
        if (hasInvalidArgs<TeamViewArguments>(args)) {
          return misTypedArgsRoute<TeamViewArguments>(args);
        }
        final typedArgs = args as TeamViewArguments ?? TeamViewArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => TeamView(team: typedArgs.team),
          settings: settings,
        );
      case Routes.manageTeamViewRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => ManageTeamView(),
          settings: settings,
        );
      case Routes.playerViewRoute:
        if (hasInvalidArgs<PlayerViewArguments>(args)) {
          return misTypedArgsRoute<PlayerViewArguments>(args);
        }
        final typedArgs = args as PlayerViewArguments ?? PlayerViewArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => PlayerView(player: typedArgs.player),
          settings: settings,
        );
      case Routes.searchPlayerViewRoute:
        if (hasInvalidArgs<SearchPlayerViewArguments>(args)) {
          return misTypedArgsRoute<SearchPlayerViewArguments>(args);
        }
        final typedArgs =
            args as SearchPlayerViewArguments ?? SearchPlayerViewArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => SearchPlayerView(team: typedArgs.team),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

// *************************************************************************
// Arguments holder classes
// **************************************************************************

//TeamView arguments holder class
class TeamViewArguments {
  final Team team;
  TeamViewArguments({this.team});
}

//PlayerView arguments holder class
class PlayerViewArguments {
  final Player player;
  PlayerViewArguments({this.player});
}

//SearchPlayerView arguments holder class
class SearchPlayerViewArguments {
  final Team team;
  SearchPlayerViewArguments({this.team});
}
