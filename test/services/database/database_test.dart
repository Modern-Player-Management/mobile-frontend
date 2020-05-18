import 'package:flutter_test/flutter_test.dart';
import 'package:mpm/services/database/database.dart';

import 'daos/event_test.dart';
import 'daos/team_test.dart';

AppDatabase db;

void database_tests() async
{
	setUp(() async {
		db = await $FloorAppDatabase.inMemoryDatabaseBuilder().build();
	});

	group('Database team tests', (){
		test('Insert one team', insert_team);
		test('Find one team', find_team);
		test('Update team', update_team);
		test('Delete team', delete_team);
	});

	group('Database event tests', (){
		test('Insert one event', insert_event);
		test('Find one event', find_event);
		test('Update event', update_event);
		test('Delete event', delete_event);
	});

	tearDown((){
		db.close();
	});
}
