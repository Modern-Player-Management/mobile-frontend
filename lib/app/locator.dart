import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'package:mpm/app/locator.iconfig.dart';
export 'package:mpm/app/router.gr.dart';

export 'package:mpm/services/database/database.dart';
export 'package:mpm/models/managers/team_manager.dart';

export 'package:mpm/services/api/auth_api.dart';
export 'package:mpm/services/api/team_api.dart';
export 'package:mpm/services/api/player_api.dart';
export 'package:mpm/services/api/event_api.dart';
export 'package:mpm/services/api/file_api.dart';

export 'package:mpm/services/secure_storage.dart';
export 'package:mpm/services/session.dart';

export 'package:stacked_services/stacked_services.dart';
export 'package:uuid/uuid.dart';
export 'package:connectivity/connectivity.dart';

final locator = GetIt.instance;

@injectableInit
Future<void> configure() async 
{
	$initGetIt(locator);
	await locator.allReady(ignorePendingAsyncCreation: false);
}