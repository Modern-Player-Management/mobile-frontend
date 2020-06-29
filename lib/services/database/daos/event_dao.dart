import 'package:floor/floor.dart';

import 'package:mpm/services/database/daos/model_dao.dart';
import 'package:mpm/services/database/models/event.dart';

@dao
abstract class EventDao extends ModelDao<Event>
{
	@Query('select * from events where id = :id')
	Future<Event> getEvent(String id);

	@Query('update events set id = :newId where id = :oldId')
	Future<void> updateEventId(String oldId, String newId);

	@Query('select * from events inner join team_events on events.id = team_events.eventId '
		'and team_events.teamId = :teamId and team_events.deleted = 0')
	Stream<List<Event>> getEvents(String teamId);

	@Query('select * from events inner join team_events on events.id = team_events.eventId '
		'and team_events.teamId = :teamId and team_events.deleted = 0')
	Future<List<Event>> getAllEvents(String teamId);
}