import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'package:mpm/app/locator.iconfig.dart';

final getIt = GetIt.instance;

@injectableInit
Future<void> configure() async
{
	$initGetIt(getIt);
	await getIt.allReady(ignorePendingAsyncCreation: false);
}