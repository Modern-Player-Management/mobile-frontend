
import 'package:auto_route/auto_route_annotations.dart';

import 'package:mpm/ui/views/splash/splash_view.dart';
import 'package:mpm/ui/views/auth/auth_view.dart';
import 'package:mpm/ui/views/home/home_view.dart';

@MaterialAutoRouter()
class $Router
{
	@initial
	SplashView splashViewRoute;

	AuthView authViewRoute;
	HomeView homeViewRoute;
}