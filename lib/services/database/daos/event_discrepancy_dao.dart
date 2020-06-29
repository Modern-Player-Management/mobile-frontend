import 'package:floor/floor.dart';

import 'package:mpm/services/database/daos/model_dao.dart';
import 'package:mpm/services/database/models/event_discrepancy.dart';

@dao
abstract class EventDiscrepancyDao extends ModelDao<EventDiscrepancy>
{
	@Query('select * from events_discrepancies where eventId = :eventId and saved = 1 and `deleted` = 0')
	Future<List<EventDiscrepancy>> getSavedEventDiscrepancies(String eventId);

	@Query('select * from events_discrepancies where eventId = :eventId and saved = 0 and `deleted` = 0')
	Future<List<EventDiscrepancy>> getUnsavedEventDiscrepancies(String eventId);

	@Query('select * from events_discrepancies where eventId = :eventId and `deleted` = 1')
	Future<List<EventDiscrepancy>> getUndeletedEventDiscrepancies(String eventId);
}