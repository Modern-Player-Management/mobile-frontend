import 'package:floor/floor.dart';

import 'package:mpm/services/database/daos/model_dao.dart';
import 'package:mpm/services/database/models/participation.dart';

@dao
abstract class ParticipationDao extends ModelDao<Participation>
{
	@Query('select * from participations where id = :id')
	Future<Participation> get(String id);

	@Query('update participations set id = :newId where id = :oldId')
	Future<void> updateId(String oldId, String newId);

	@Query('select * from participations where teamId = :teamId and deleted = 0 ')
	Stream<List<Participation>> getStream(String teamId);

	@Query('select * from participations where teamId = :teamId and deleted = 0 ')
	Future<List<Participation>> getList(String teamId);

	@Query('select * from participations where teamId = :teamId '
		'and saved = 1 and deleted = 0')
	Future<List<Participation>> getSaved(String teamId);

	@Query('select * from participations where teamId = :teamId '
		'and saved = 0 and deleted = 0')
	Future<List<Participation>> getUnsaved(String teamId);

	@Query('select * from participations where teamId = :teamId and deleted = 1')
	Future<List<Participation>> getUndeleted(String teamId);
}