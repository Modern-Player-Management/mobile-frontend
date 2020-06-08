
import 'package:auto_route/auto_route_annotations.dart';

import 'package:mpm/ui/views/splash/splash_view.dart';

import 'package:mpm/ui/views/auth/auth_view.dart';
import 'package:mpm/ui/views/auth/login/login_view.dart';
import 'package:mpm/ui/views/auth/register/register_view.dart';

import 'package:mpm/ui/views/home/home_view.dart';

import 'package:mpm/ui/views/team/team_view.dart';
import 'package:mpm/ui/views/team/manage/manage_team_view.dart';

import 'package:mpm/ui/views/player/player_view.dart';
import 'package:mpm/ui/views/player/search/search_player_view.dart';

@MaterialAutoRouter()
class $Router
{
	@initial
	SplashView splashViewRoute;

	AuthView authViewRoute;
	LoginView loginViewRoute;
	RegisterView registerViewRoute;

	HomeView homeViewRoute;

	TeamView teamViewRoute;
	ManageTeamView manageTeamViewRoute;

	PlayerView playerViewRoute;
	SearchPlayerView searchPlayerViewRoute;
}