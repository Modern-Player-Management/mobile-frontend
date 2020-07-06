import 'package:floor/floor.dart';

import 'package:mpm/services/database/daos/model_dao.dart';
import 'package:mpm/services/database/models/team_game.dart';

@dao
abstract class TeamGameDao extends ModelDao<TeamGame>
{
	@Query('select * from team_games where teamId = :teamId and deleted = 0')
	Stream<List<TeamGame>> getStream(String teamId);

	@Query('select * from team_games where teamId = :teamId and deleted = 0')
	Future<List<TeamGame>> getList(String teamId);

	@Query('select * from team_games where teamId = :teamId and saved = 1 and deleted = 0')
	Future<List<TeamGame>> getSaved(String teamId);

	@Query('select * from team_games where teamId = :teamId and saved = 0 and deleted = 0')
	Future<List<TeamGame>> getUnsaved(String teamId);

	@Query('select * from team_games where teamId = :teamId and deleted = 1')
	Future<List<TeamGame>> getUndeleted(String teamId);
}