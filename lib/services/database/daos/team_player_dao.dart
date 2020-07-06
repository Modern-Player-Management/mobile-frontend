import 'package:floor/floor.dart';

import 'package:mpm/services/database/daos/model_dao.dart';
import 'package:mpm/services/database/models/team_player.dart';

@dao
abstract class TeamPlayerDao extends ModelDao<TeamPlayer>
{
	@Query('select * from team_players where teamId = :teamId and deleted = 0')
	Stream<List<TeamPlayer>> getStream(String teamId);

	@Query('select * from team_players where teamId = :teamId and deleted = 0')
	Future<List<TeamPlayer>> getList(String teamId);

	@Query('select * from team_players where teamId = :teamId and saved = 1 and deleted = 0')
	Future<List<TeamPlayer>> getSaved(String teamId);

	@Query('select * from team_players where teamId = :teamId and saved = 0 and deleted = 0')
	Future<List<TeamPlayer>> getUnsaved(String teamId);

	@Query('select * from team_players where teamId = :teamId and deleted = 1')
	Future<List<TeamPlayer>> getUndeleted(String teamId);
}