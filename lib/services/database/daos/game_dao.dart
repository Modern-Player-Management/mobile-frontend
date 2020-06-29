import 'package:floor/floor.dart';

import 'package:mpm/services/database/daos/model_dao.dart';
import 'package:mpm/services/database/models/game.dart';

@dao
abstract class GameDao extends ModelDao<Game>
{
	@Query('select * from events where team = :team and `delete` = 0')
	Stream<List<Game>> getGames(String team);

	@Query('select * from events where team = :team and save = 1 and `delete` = 0')
	Future<List<Game>> getSavedGames(String team);

	@Query('select * from events where team = :team and save = 0 and `delete` = 0')
	Future<List<Game>> getUnsavedGames(String team);

	@Query('select * from events where team = :team and `delete` = 1')
	Future<List<Game>> getUndeletedGames(String team);
}