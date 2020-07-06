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

	@Query('select * from discrepancies where teamId = :teamId and deleted = 0 ')
	Stream<List<Discrepancy>> getStream(String teamId);

	@Query('select * from discrepancies where teamId = :teamId and deleted = 0 ')
	Future<List<Discrepancy>> getList(String teamId);

	@Query('select * from discrepancies where teamId = :teamId '
		'and saved = 1 and deleted = 0')
	Future<List<Discrepancy>> getSaved(String teamId);

	@Query('select * from discrepancies where teamId = :teamId '
		'and saved = 0 and deleted = 0')
	Future<List<Discrepancy>> getUnsaved(String teamId);

	@Query('select * from discrepancies where teamId = :teamId and deleted = 1')
	Future<List<Discrepancy>> getUndeleted(String teamId);
}