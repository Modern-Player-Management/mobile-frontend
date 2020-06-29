import 'package:floor/floor.dart';

import 'package:mpm/services/database/daos/model_dao.dart';
import 'package:mpm/services/database/models/event_discrepancy.dart';

@dao
abstract class EventDiscrepancyDao extends ModelDao<EventDiscrepancy>
{
	@Query('select * from events_discrepancies where eventId = :eventId and playerId = :playerId')
	Future<EventDiscrepancy> getEventDiscrepancy(String eventId, String playerId);

	@Query('select * from events_discrepancies where eventId = :eventId and save = 1 and `delete` = 0')
	Future<List<EventDiscrepancy>> getSavedEventDiscrepancies(String eventId);

	@Query('select * from events_discrepancies where eventId = :eventId and save = 0 and `delete` = 0')
	Future<List<EventDiscrepancy>> getUnsavedEventDiscrepancies(String eventId);

	@Query('select * from events_discrepancies where eventId = :eventId and `delete` = 1')
	Future<List<EventDiscrepancy>> getUndeletedEventDiscrepancies(String eventId);

	@Insert(
		onConflict: OnConflictStrategy.replace
	)
	Future<int> insertEventDiscrepancy(EventDiscrepancy eventDiscrepancy);

	@update
	Future<int> updateModelDiscrepancy(EventDiscrepancy eventDiscrepancy);

	@delete
	Future<int> deleteModelDiscrepancy(EventDiscrepancy eventDiscrepancy);
}