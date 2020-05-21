// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:mpm/services/database/database.dart';
import 'package:mpm/services/api/auth_api.dart';
import 'package:mpm/services/third_party_services.dart';
import 'package:connectivity/connectivity.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:mpm/services/secure_storage.dart';
import 'package:mpm/services/session.dart';
import 'package:mpm/services/api/team_api.dart';
import 'package:mpm/models/managers/team_manager.dart';
import 'package:uuid/uuid.dart';
import 'package:get_it/get_it.dart';

void $initGetIt(GetIt g, {String environment}) {
  final thirdPartyServices = _$ThirdPartyServices();
  g.registerLazySingleton<AuthApi>(() => AuthApi.create());
  g.registerLazySingleton<Connectivity>(() => thirdPartyServices.connectivity);
  g.registerLazySingleton<DialogService>(
      () => thirdPartyServices.dialogService);
  g.registerLazySingleton<NavigationService>(
      () => thirdPartyServices.navigationService);
  g.registerLazySingleton<Session>(() => Session());
  g.registerLazySingleton<SnackbarService>(
      () => thirdPartyServices.snackBarService);
  g.registerLazySingleton<TeamApi>(() => TeamApi.create());
  g.registerFactoryParam<TeamManager, Function, dynamic>(
      (validResponse, _) => TeamManager(validResponse: validResponse));
  g.registerLazySingleton<Uuid>(() => thirdPartyServices.uuid);

  //Eager singletons must be registered in the right order
  g.registerSingletonAsync<AppDatabase>(() => AppDatabase.create());
  g.registerSingletonAsync<SecureStorage>(() => SecureStorage.create());
}

class _$ThirdPartyServices extends ThirdPartyServices {
  @override
  DialogService get dialogService => DialogService();
  @override
  NavigationService get navigationService => NavigationService();
  @override
  SnackbarService get snackBarService => SnackbarService();
}
