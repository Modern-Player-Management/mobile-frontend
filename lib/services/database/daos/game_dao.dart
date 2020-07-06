import 'package:floor/floor.dart';

import 'package:mpm/services/database/daos/model_dao.dart';
import 'package:mpm/services/database/models/game.dart';

@dao
abstract class GameDao extends ModelDao<Game>
{
	@Query('select * from events where id = :id')
	Future<Game> get(String id);

	@Query('update games set id = :newId where id = :oldId')
	Future<void> updateId(String oldId, String newId);

	@Query('select * from games inner join team_games on games.id = team_games.gameId '
		'and team_games.teamId = :teamId and `team_games.delete` = 0')
	Stream<List<Game>> getStream(String teamId);

	@Query('select * from games inner join team_games on games.id = team_games.gameId '
		'and team_games.teamId = :teamId and `team_games.delete` = 0')
	Future<List<Game>> getList(String teamId);
}