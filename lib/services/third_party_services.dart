import 'package:connectivity/connectivity.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:mpm/app/locator.dart';

@module
abstract class ThirdPartyServices
{
	@lazySingleton
	NavigationService get navigationService;

	@lazySingleton
	DialogService get dialogService;
	
	@lazySingleton
	SnackbarService get snackBarService;

	@lazySingleton
	Uuid get uuid => Uuid();

	@lazySingleton
	Connectivity get connectivity => Connectivity();
}