import 'package:floor/floor.dart';

import 'package:mpm/services/database/models/event.dart';

@dao
abstract class EventDao
{
	@Query('select * from events where user = :user and `delete` = 0')
	Stream<List<Event>> getEvents(String user);

	@Query('select * from events where user = :user and save = 1 and `delete` = 0')
	Future<List<Event>> getSavedEvents(String user);

	@Query('select * from events where user = :user and save = 0 and `delete` = 0')
	Future<List<Event>> getUnsavedEvents(String user);

	@Query('select * from events where user = :user and `delete` = 1')
	Future<List<Event>> getUndeletedEvents(String user);

	@insert
	Future<void> insertEvent(Event unit);

	@update
	Future<void> updateEvent(Event unit);

	@delete
	Future<void> deleteEvent(Event unit);
}