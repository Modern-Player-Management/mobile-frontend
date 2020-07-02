import 'package:floor/floor.dart';

import 'package:mpm/services/database/daos/model_dao.dart';
import 'package:mpm/services/database/models/event_participation.dart';

@dao
abstract class EventParticipationDao extends ModelDao<EventParticipation>
{
	@Query('select * from events_participations where eventId = :eventId and deleted = 0')
	Stream<List<EventParticipation>> getEventDiscrepancies(String eventId);

	@Query('select * from events_participations where eventId = :eventId and deleted = 0')
	Future<List<EventParticipation>> getAllEventDiscrepancies(String eventId);

	@Query('select * from events_participations where eventId = :eventId and saved = 1 and `deleted` = 0')
	Future<List<EventParticipation>> getSavedEventParticipations(String eventId);

	@Query('select * from events_participations where eventId = :eventId and saved = 0 and `deleted` = 0')
	Future<List<EventParticipation>> getUnsavedEventParticipations(String eventId);

	@Query('select * from events_participations where eventId = :eventId and `deleted` = 1')
	Future<List<EventParticipation>> getUndeletedEventParticipations(String eventId);
}