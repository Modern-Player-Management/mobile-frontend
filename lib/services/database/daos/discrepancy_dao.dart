import 'package:floor/floor.dart';

import 'package:mpm/services/database/daos/model_dao.dart';
import 'package:mpm/services/database/models/discrepancy.dart';

@dao
abstract class DiscrepancyDao extends ModelDao<Discrepancy>
{
	@Query('select * from discrepancies where id = :id')
	Future<Discrepancy> get(String id);

	@Query('update discrepancies set id = :newId where id = :oldId')
	Future<void> updateId(String oldId, String newId);

	@Query('select * from discrepancies left join event_discrepancies on '
		'discrepancies.id = event_discrepancies.discrepancyId and '
		'event_discrepancies.eventId = :eventId and event_discrepancies.deleted = 0')
	Stream<List<Discrepancy>> getStream(String eventId);

	@Query('select * from discrepancies left join event_discrepancies on '
		'discrepancies.id = event_discrepancies.discrepancyId and '
		'event_discrepancies.eventId = :eventId and event_discrepancies.deleted = 0')
	Future<List<Discrepancy>> getList(String eventId);

	@Query('select * from discrepancies left join event_discrepancies on '
		'discrepancies.id = event_discrepancies.discrepancyId and '
		'event_discrepancies.eventId = :eventId and event_discrepancies.saved = 1 '
		'event_discrepancies.deleted = 0')
	Future<List<Discrepancy>> getSaved(String eventId);

	@Query('select * from discrepancies left join event_discrepancies on '
		'discrepancies.id = event_discrepancies.discrepancyId and '
		'event_discrepancies.eventId = :eventId and event_discrepancies.saved = 0 '
		'event_discrepancies.deleted = 0')
	Future<List<Discrepancy>> getUnsaved(String eventId);

	@Query('select * from discrepancies left join event_discrepancies on '
		'discrepancies.id = event_discrepancies.discrepancyId and '
		'event_discrepancies.eventId = :eventId and event_discrepancies.deleted = 1')
	Future<List<Discrepancy>> getUndeleted(String eventId);
}