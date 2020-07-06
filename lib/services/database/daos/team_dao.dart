import 'package:floor/floor.dart';

import 'package:mpm/services/database/daos/model_dao.dart';
import 'package:mpm/services/database/models/team.dart';

@dao
abstract class TeamDao extends ModelDao<Team>
{
	@Query('select * from teams where player = :player and deleted = 0 order by name')
	Stream<List<Team>> getStream(String player);

	@Query('select * from teams where player = :player and deleted = 0 order by name')
	Future<List<Team>> getList(String player);

	@Query('select * from teams where player = :player and saved = 1 and delete = 0')
	Future<List<Team>> getSaved(String player);

	@Query('select * from teams where player = :player and saved = 0 and deleted = 0')
	Future<List<Team>> getUnsaved(String player);

	@Query('select * from teams where player = :player and deleted = 1')
	Future<List<Team>> getUndeleted(String player);

	@Query('update teams set id = :newId where id = :oldId')
	Future<void> updateId(String oldId, String newId);
}