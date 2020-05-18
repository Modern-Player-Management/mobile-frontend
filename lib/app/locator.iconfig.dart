// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:mpm/services/database/database.dart';
import 'package:mpm/services/api/auth_api.dart';
import 'package:mpm/services/third_party_services.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:mpm/services/secure_storage.dart';
import 'package:get_it/get_it.dart';

void $initGetIt(GetIt g, {String environment}) {
  final thirdPartyServices = _$ThirdPartyServices();
  g.registerLazySingleton<AuthApi>(() => AuthApi.create());
  g.registerLazySingleton<DialogService>(
      () => thirdPartyServices.dialogService);
  g.registerLazySingleton<NavigationService>(
      () => thirdPartyServices.navigationService);
  g.registerLazySingleton<SnackbarService>(
      () => thirdPartyServices.snackBarService);

  //Eager singletons must be registered in the right order
  g.registerSingletonAsync<AppDatabase>(() => AppDatabase.create());
  g.registerSingleton<SecureStorage>(SecureStorage());
}

class _$ThirdPartyServices extends ThirdPartyServices {
  @override
  DialogService get dialogService => DialogService();
  @override
  NavigationService get navigationService => NavigationService();
  @override
  SnackbarService get snackBarService => SnackbarService();
}
