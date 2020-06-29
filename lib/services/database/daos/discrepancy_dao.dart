import 'package:floor/floor.dart';

import 'package:mpm/services/database/daos/model_dao.dart';
import 'package:mpm/services/database/models/discrepancy.dart';

@dao
abstract class DiscrepancyDao extends ModelDao<Discrepancy>
{
	@Query('select * from discrepancies where eventId = :eventId and deleted = 0')
	Stream<List<Discrepancy>> getDiscrepancies(String eventId);

	@Query('select * from discrepancies where eventId = :eventId and saved = 1 and deleted = 0')
	Future<List<Discrepancy>> getSavedDiscrepancies(String eventId);

	@Query('select * from discrepancies where eventId = :eventId and saved = 0 and deleted = 0')
	Future<List<Discrepancy>> getUnsavedDiscrepancies(String eventId);

	@Query('select * from discrepancies where eventId = :eventId and `deleted` = 1')
	Future<List<Discrepancy>> getUndeletedDiscrepancies(String eventId);
}