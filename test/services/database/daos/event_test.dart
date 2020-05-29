import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:sqflite_ffi_test/sqflite_ffi_test.dart';

import 'package:mpm/services/database/database.dart';

import 'team_test.dart';

AppDatabase _db;

void main() async
{
	TestWidgetsFlutterBinding.ensureInitialized();
	sqfliteFfiTestInit();

	setUp(() async {
		_db = await $FloorAppDatabase.inMemoryDatabaseBuilder().build();
	});

	group('simple database event tests', (){
		test('insert one event',insert_event);
		test('find one event', find_event);
		test('update event', update_event);
		test('delete event', delete_event);
	});

	tearDown((){
		_db.close();
	});	
}

Future<Event> insert_event() async
{
	await insert_team(_db);

	final event = Event(
		id: "id",
		team: teamId,
		name: "title",
		description: "description"
	);

	int id = await _db.eventDao.insertEvent(event);

	expect(id, equals(1));

	return event;
}

void find_event() async
{
	await insert_event();

	final events = await _db.eventDao.getEvents(teamId).first;

	expect(events.length, equals(1));
}

void update_event() async
{
	final event = await insert_event();

	event.name = "test";
	int rows = await _db.eventDao.updateEvent(event);

	expect(rows, equals(1));

	final events = await _db.eventDao.getEvents(teamId).first;

	expect(events[0].name, equals("test"));
}

void delete_event() async
{
	final event = await insert_event();

	await _db.eventDao.deleteEvent(event);

	final events = await _db.eventDao.getEvents(teamId).first;

	expect(events.length, equals(0));
}