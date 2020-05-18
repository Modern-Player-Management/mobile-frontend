import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';

import 'package:mpm/services/database/database.dart';

import '../database_test.dart';
import 'team_test.dart';

Future<Event> insert_event() async
{
	final team = await insert_team();

	final event = Event(
		id: "id",
		team: teamId,
		title: "title",
		description: "description"
	);

	int id = await db.eventDao.insertEvent(event);

	expect(id, equals(1));

	return event;
}

void find_event() async
{
	await insert_event();

	final events = await db.eventDao.getEvents(teamId).first;

	expect(events.length, equals(1));
}

void update_event() async
{
	final event = await insert_event();

	event.title = "test";
	int rows = await db.eventDao.updateEvent(event);

	expect(rows, equals(1));

	final events = await db.eventDao.getEvents(teamId).first;

	expect(events[0].title, equals("test"));
}

void delete_event() async
{
	final event = await insert_event();

	await db.eventDao.deleteEvent(event);

	final events = await db.eventDao.getEvents(teamId).first;

	expect(events.length, equals(0));
}