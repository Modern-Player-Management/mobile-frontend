import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:sqflite_ffi_test/sqflite_ffi_test.dart';

import 'package:mpm/app/locator.dart';
import 'package:mpm/services/database/database.dart';

import 'team_test.dart';

AppDatabase _db;

void main()
{
	TestWidgetsFlutterBinding.ensureInitialized();
	sqfliteFfiTestInit();

	setUp(() async {
		await configure(true);
		_db = locator<AppDatabase>();
	});

	group('simple database event tests', (){
		test('insert one event',insertEvent);
		test('find one event', findEvent);
		test('update event', updateEvent);
		test('delete event', deleteEvent);
	});

	tearDown((){
		_db.close();
	});
}

Future<Event> insertEvent() async
{
	await insertTeam(_db);

	final event = Event(
		id: "id",
		team: teamId,
		name: "title",
		description: "description"
	);

	int id = await _db.eventDao.insertModel(event);

	expect(id, equals(1));

	return event;
}

void findEvent() async
{
	await insertEvent();

	final events = await _db.eventDao.getEvents(teamId).first;

	expect(events.length, equals(1));
}

void updateEvent() async
{
	final event = await insertEvent();

	event.name = "test";
	int rows = await _db.eventDao.updateModel(event);

	expect(rows, equals(1));

	final events = await _db.eventDao.getEvents(teamId).first;

	expect(events[0].name, equals("test"));
}

void deleteEvent() async
{
	final event = await insertEvent();

	var rows = await _db.eventDao.deleteModel(event);

	expect(rows, equals(1));

	final events = await _db.eventDao.getEvents(teamId).first;

	expect(events.length, equals(0));
}