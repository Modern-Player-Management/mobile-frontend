import 'package:floor/floor.dart';

import 'package:mpm/services/database/daos/model_dao.dart';
import 'package:mpm/services/database/models/discrepancy.dart';

@dao
abstract class DiscrepancyDao extends ModelDao<Discrepancy>
{
	@Query('select * from discrepancies where id = :id')
	Future<Discrepancy> getDiscrepancy(String id);

	@Query('update discrepancies set id = :newId where id = :oldId')
	Future<void> updateDiscrepancyId(String oldId, String newId);

	@Query('select * from discrepancies inner join event_discrepancies on '
		'discrepancies.id = event_discrepancies.discrepancyId and '
		'event_discrepancies.eventId = :eventId and `event_discrepancies.deleted` = 0')
	Stream<List<Discrepancy>> getDiscrepancies(String eventId);

	@Query('select * from discrepancies inner join event_discrepancies on '
		'discrepancies.id = event_discrepancies.discrepancyId and '
		'event_discrepancies.eventId = :eventId and `event_discrepancies.deleted` = 0')
	Future<List<Discrepancy>> getAllDiscrepancies(String eventId);
}