
import 'package:auto_route/auto_route_annotations.dart';

import 'package:mpm/ui/views/splash/splash_view.dart';

import 'package:mpm/ui/views/auth/auth_view.dart';
import 'package:mpm/ui/views/auth/login/login_view.dart';
import 'package:mpm/ui/views/auth/register/register_view.dart';

import 'package:mpm/ui/views/home/home_view.dart';
import 'package:mpm/ui/views/team/create_team/create_team_view.dart';

@MaterialAutoRouter()
class $Router
{
	@initial
	SplashView splashViewRoute;

	AuthView authViewRoute;
	LoginView loginViewRoute;
	RegisterView registerViewRoute;

	HomeView homeViewRoute;

	CreateTeamView createTeamViewRoute;
}