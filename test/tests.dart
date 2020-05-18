import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_ffi_test/sqflite_ffi_test.dart';

import 'services/api/api_test.dart';
import 'services/database/database_test.dart';

void main() 
{
	TestWidgetsFlutterBinding.ensureInitialized();
	sqfliteFfiTestInit();

	database_tests();
	api_tests();
}
