import 'package:floor/floor.dart';

import 'package:mpm/services/database/daos/model_dao.dart';
import 'package:mpm/services/database/models/discrepancy.dart';

@dao
abstract class DiscrepancyDao extends ModelDao<Discrepancy>
{
	@Query('select * from discrepancies where id = :id')
	Future<Discrepancy> get(String id);

	@Query('select * from discrepancies where eventId = :eventId and deleted = 0 ')
	Stream<List<Discrepancy>> getStream(String eventId);

	@Query('select * from discrepancies where eventId = :eventId and deleted = 0 ')
	Future<List<Discrepancy>> getList(String eventId);

	@Query('select * from discrepancies where eventId = :eventId '
		'and saved = 1 and deleted = 0')
	Future<List<Discrepancy>> getSaved(String eventId);

	@Query('select * from discrepancies where eventId = :eventId '
		'and saved = 0 and deleted = 0')
	Future<List<Discrepancy>> getUnsaved(String eventId);

	@Query('select * from discrepancies where eventId = :eventId and deleted = 1')
	Future<List<Discrepancy>> getUndeleted(String eventId);
}