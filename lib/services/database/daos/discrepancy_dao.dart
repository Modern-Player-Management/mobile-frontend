import 'package:floor/floor.dart';

import 'package:mpm/services/database/daos/model_dao.dart';
import 'package:mpm/services/database/models/discrepancy.dart';

@dao
abstract class DiscrepancyDao extends ModelDao<Discrepancy>
{
	@Query('select * from discrepancies where eventId = :eventId and `delete` = 0')
	Stream<List<Discrepancy>> getDiscrepancies(String eventId);

	@Query('select * from discrepancies where eventId = :eventId and save = 1 and `delete` = 0')
	Future<List<Discrepancy>> getSavedDiscrepancies(String eventId);

	@Query('select * from discrepancies where eventId = :eventId and save = 0 and `delete` = 0')
	Future<List<Discrepancy>> getUnsavedDiscrepancies(String eventId);

	@Query('select * from discrepancies where eventId = :eventId and `delete` = 1')
	Future<List<Discrepancy>> getUndeletedDiscrepancies(String eventId);
}