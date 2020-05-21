import 'package:floor/floor.dart';

import 'package:mpm/services/database/models/event.dart';

@dao
abstract class EventDao
{
	@Query('select * from events where team = :team and `delete` = 0')
	Stream<List<Event>> getEvents(String team);

	@Query('select * from events where team = :team and save = 1 and `delete` = 0')
	Future<List<Event>> getSavedEvents(String team);

	@Query('select * from events where team = :team and save = 0 and `delete` = 0')
	Future<List<Event>> getUnsavedEvents(String team);

	@Query('select * from events where team = :team and `delete` = 1')
	Future<List<Event>> getUndeletedEvents(String team);

	@Insert(
		onConflict: OnConflictStrategy.REPLACE
	)
	Future<int> insertEvent(Event event);

	@update
	Future<int> updateEvent(Event event);

	@delete
	Future<int> deleteEvent(Event event);
}