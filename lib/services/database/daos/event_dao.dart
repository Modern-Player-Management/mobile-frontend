import 'package:floor/floor.dart';

import 'package:mpm/services/database/daos/model_dao.dart';
import 'package:mpm/services/database/models/event.dart';

@dao
abstract class EventDao extends ModelDao<Event>
{
	@Query('select * from events where id = :id')
	Future<Event> get(String id);

	@Query('update events set id = :newId where id = :oldId')
	Future<void> updateId(String oldId, String newId);

	@Query('select * from events left join team_events on events.id = team_events.eventId '
		'and team_events.teamId = :teamId and team_events.deleted = 0')
	Stream<List<Event>> getStream(String teamId);

	@Query('select * from events left join team_events on events.id = team_events.eventId '
		'and team_events.teamId = :teamId and team_events.deleted = 0')
	Future<List<Event>> getList(String teamId);

	@Query('select * from events left join team_events on events.id = team_events.eventId '
		'and team_events.teamId = :teamId and team_events.saved = 1 '
		'team_events.deleted = 0')
	Future<List<Event>> getSaved(String teamId);

	@Query('select * from events left join team_events on events.id = team_events.eventId '
		'and team_events.teamId = :teamId and team_events.saved = 0 '
		'team_events.deleted = 0')
	Future<List<Event>> getUnsaved(String teamId);

	@Query('select * from events left join team_events on events.id = team_events.eventId '
		'and team_events.teamId = :teamId and team_events.deleted = 1')
	Future<List<Event>> getUndeleted(String teamId);
}