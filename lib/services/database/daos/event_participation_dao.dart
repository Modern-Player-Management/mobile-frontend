import 'package:floor/floor.dart';

import 'package:mpm/services/database/daos/model_dao.dart';
import 'package:mpm/services/database/models/event_participation.dart';

@dao
abstract class EventParticipationDao extends ModelDao<EventParticipation>
{
	@Query('select * from events_participations where eventId = :eventId and deleted = 0')
	Stream<List<EventParticipation>> getStream(String eventId);

	@Query('select * from events_participations where eventId = :eventId and deleted = 0')
	Future<List<EventParticipation>> getList(String eventId);

	@Query('select * from events_participations where eventId = :eventId and saved = 1 and `deleted` = 0')
	Future<List<EventParticipation>> getSaved(String eventId);

	@Query('select * from events_participations where eventId = :eventId and saved = 0 and `deleted` = 0')
	Future<List<EventParticipation>> getUnsaved(String eventId);

	@Query('select * from events_participations where eventId = :eventId and `deleted` = 1')
	Future<List<EventParticipation>> getUndeleted(String eventId);
}