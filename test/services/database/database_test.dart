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

	group('simple database team tests', (){
		test('insert one team', insert_team);
		test('find one team', find_team);
		test('update team', update_team);
		test('delete team', delete_team);
	});

	group('simple database event tests', (){
		test('insert one event', insert_event);
		test('find one event', find_event);
		test('update event', update_event);
		test('delete event', delete_event);
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
		user: user,
		name: "name"
	);

	final event1 = Event(
		id: "1",
		team: teamId,
		title: "test",
		description: "test"
	);

	final event2 = Event(
		id: "2",
		team: teamId,
		title: "test",
		description: "test"
	);

	await db.teamDao.insertTeam(team);
	await db.eventDao.insertEvent(event1);
	await db.eventDao.insertEvent(event2);

	await db.teamDao.deleteTeam(team);

	final teams = await db.teamDao.getTeams(user).first;
	expect(teams.length, equals(0));

	final events = await db.eventDao.getEvents(teamId).first;
	expect(events.length, equals(0));
}