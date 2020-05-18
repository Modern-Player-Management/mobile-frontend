// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:mpm/services/database/database.dart';
import 'package:mpm/services/api/auth_api.dart';
import 'package:mpm/services/secure_storage.dart';
import 'package:get_it/get_it.dart';

void $initGetIt(GetIt g, {String environment}) {
  g.registerLazySingleton<AuthApi>(() => AuthApi.create());

  //Eager singletons must be registered in the right order
  g.registerSingletonAsync<AppDatabase>(() => AppDatabase.create());
  g.registerSingleton<SecureStorage>(SecureStorage());
}
