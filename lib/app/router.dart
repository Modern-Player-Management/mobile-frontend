
import 'package:auto_route/auto_route_annotations.dart';

import 'package:mpm/services/database/models/models.dart';

import 'package:mpm/ui/views/splash/splash_view.dart';

import 'package:mpm/ui/views/auth/auth_view.dart';
import 'package:mpm/ui/views/auth/login/login_view.dart';
import 'package:mpm/ui/views/auth/register/register_view.dart';

import 'package:mpm/ui/views/home/home_view.dart';
import 'package:mpm/ui/views/team/event/manage/manage_event_view.dart';

import 'package:mpm/ui/views/team/team_view.dart';
import 'package:mpm/ui/views/team/manage/manage_team_view.dart';

import 'package:mpm/ui/views/player/player_view.dart';
import 'package:mpm/ui/views/player/search/search_player_view.dart';

@MaterialAutoRouter(
	routes: [
		AdaptiveRoute(page: SplashView, initial: true),

		AdaptiveRoute(page: AuthView),
		AdaptiveRoute(page: LoginView),
		AdaptiveRoute(page: RegisterView),

		AdaptiveRoute(page: HomeView),

		AdaptiveRoute(page: TeamView),
		AdaptiveRoute<Team>(page: ManageTeamView),
		AdaptiveRoute<Event>(page: ManageEventView),

		AdaptiveRoute(page: PlayerView),
		AdaptiveRoute(page: SearchPlayerView),
	]
)
class $Router
{
}