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
import 'package:mpm/ui/views/team/event/manage/manage_event_view.dart';
import 'package:mpm/services/database/models/event.dart';
import 'package:mpm/ui/views/team/game/team_game_view.dart';
import 'package:mpm/services/database/models/game.dart';
import 'package:mpm/ui/views/player/player_view.dart';
import 'package:mpm/ui/views/player/search/search_player_view.dart';

class Routes {
  static const String splashView = '/';
  static const String authView = '/auth-view';
  static const String loginView = '/login-view';
  static const String registerView = '/register-view';
  static const String homeView = '/home-view';
  static const String teamView = '/team-view';
  static const String manageTeamView = '/manage-team-view';
  static const String manageEventView = '/manage-event-view';
  static const String teamGameView = '/team-game-view';
  static const String playerView = '/player-view';
  static const String searchPlayerView = '/search-player-view';
  static const all = <String>{
    splashView,
    authView,
    loginView,
    registerView,
    homeView,
    teamView,
    manageTeamView,
    manageEventView,
    teamGameView,
    playerView,
    searchPlayerView,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.splashView, page: SplashView),
    RouteDef(Routes.authView, page: AuthView),
    RouteDef(Routes.loginView, page: LoginView),
    RouteDef(Routes.registerView, page: RegisterView),
    RouteDef(Routes.homeView, page: HomeView),
    RouteDef(Routes.teamView, page: TeamView),
    RouteDef(Routes.manageTeamView, page: ManageTeamView),
    RouteDef(Routes.manageEventView, page: ManageEventView),
    RouteDef(Routes.teamGameView, page: TeamGameView),
    RouteDef(Routes.playerView, page: PlayerView),
    RouteDef(Routes.searchPlayerView, page: SearchPlayerView),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    SplashView: (RouteData data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => SplashView(),
        settings: data,
      );
    },
    AuthView: (RouteData data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => AuthView(),
        settings: data,
      );
    },
    LoginView: (RouteData data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => LoginView(),
        settings: data,
      );
    },
    RegisterView: (RouteData data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => RegisterView(),
        settings: data,
      );
    },
    HomeView: (RouteData data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => HomeView(),
        settings: data,
      );
    },
    TeamView: (RouteData data) {
      var args =
          data.getArgs<TeamViewArguments>(orElse: () => TeamViewArguments());
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => TeamView(team: args.team),
        settings: data,
      );
    },
    ManageTeamView: (RouteData data) {
      var args = data.getArgs<ManageTeamViewArguments>(
          orElse: () => ManageTeamViewArguments());
      return buildAdaptivePageRoute<Team>(
        builder: (context) => ManageTeamView(team: args.team),
        settings: data,
      );
    },
    ManageEventView: (RouteData data) {
      var args = data.getArgs<ManageEventViewArguments>(nullOk: false);
      return buildAdaptivePageRoute<Event>(
        builder: (context) =>
            ManageEventView(team: args.team, event: args.event),
        settings: data,
      );
    },
    TeamGameView: (RouteData data) {
      var args = data.getArgs<TeamGameViewArguments>(nullOk: false);
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => TeamGameView(game: args.game),
        settings: data,
      );
    },
    PlayerView: (RouteData data) {
      var args = data.getArgs<PlayerViewArguments>(
          orElse: () => PlayerViewArguments());
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => PlayerView(playerId: args.playerId),
        settings: data,
      );
    },
    SearchPlayerView: (RouteData data) {
      var args = data.getArgs<SearchPlayerViewArguments>(
          orElse: () => SearchPlayerViewArguments());
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => SearchPlayerView(team: args.team),
        settings: data,
      );
    },
  };
}

// *************************************************************************
// Arguments holder classes
// **************************************************************************

//TeamView arguments holder class
class TeamViewArguments {
  final Team team;
  TeamViewArguments({this.team});
}

//ManageTeamView arguments holder class
class ManageTeamViewArguments {
  final Team team;
  ManageTeamViewArguments({this.team});
}

//ManageEventView arguments holder class
class ManageEventViewArguments {
  final Team team;
  final Event event;
  ManageEventViewArguments({@required this.team, this.event});
}

//TeamGameView arguments holder class
class TeamGameViewArguments {
  final Game game;
  TeamGameViewArguments({@required this.game});
}

//PlayerView arguments holder class
class PlayerViewArguments {
  final String playerId;
  PlayerViewArguments({this.playerId});
}

//SearchPlayerView arguments holder class
class SearchPlayerViewArguments {
  final Team team;
  SearchPlayerViewArguments({this.team});
}
