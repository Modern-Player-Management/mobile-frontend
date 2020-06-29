import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_ffi_test/sqflite_ffi_test.dart';

import 'package:mpm/services/database/database.dart';

import 'daos/team_test.dart';

AppDatabase db;

void main() async
{
	setUp(() async {
		TestWidgetsFlutterBinding.ensureInitialized();
		sqfliteFfiTestInit();
		db = await $FloorAppDatabase.inMemoryDatabaseBuilder().build();
	});

	group('complex database tests', (){
		test('delete team with two events', delete_team_with_two_events);
	});

	tearDown((){
		db.close();
	});
}

void delete_team_with_two_events() async
{
	final team = Team(
		id: teamId,
		player: player,
		name: "name"
	);

	final event1 = Event(
		id: "1",
		team: teamId,
		name: "test",
		description: "test"
	);

	final event2 = Event(
		id: "2",
		team: teamId,
		name: "test",
		description: "test"
	);

	await db.teamDao.insertModel(team);
	await db.eventDao.insertModel(event1);
	await db.eventDao.insertModel(event2);

	await db.teamDao.deleteModel(team);

	final teams = await db.teamDao.getTeams(player).first;
	expect(teams.length, equals(0));

	final events = await db.eventDao.getEvents(teamId).first;
	expect(events.length, equals(0));
}