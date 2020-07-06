import 'package:floor/floor.dart';

import 'package:mpm/services/database/daos/model_dao.dart';
import 'package:mpm/services/database/models/game.dart';

@dao
abstract class GameDao extends ModelDao<Game>
{
	@Query('select * from games where id = :id')
	Future<Game> get(String id);

	@Query('update games set id = :newId where id = :oldId')
	Future<void> updateId(String oldId, String newId);

	@Query('select * from games where teamId = :teamId and deleted = 0 ')
	Stream<List<Game>> getStream(String teamId);

	@Query('select * from games where teamId = :teamId and deleted = 0 ')
	Future<List<Game>> getList(String teamId);

	@Query('select * from games where teamId = :teamId '
		'and saved = 1 and deleted = 0')
	Future<List<Game>> getSaved(String teamId);

	@Query('select * from games where teamId = :teamId '
		'and saved = 0 and deleted = 0')
	Future<List<Game>> getUnsaved(String teamId);

	@Query('select * from games where teamId = :teamId and deleted = 1')
	Future<List<Game>> getUndeleted(String teamId);
}