import 'package:floor/floor.dart';

import 'package:mpm/services/database/daos/model_dao.dart';
import 'package:mpm/services/database/models/player_stats.dart';

@dao
abstract class PlayerStatsDao extends ModelDao<PlayerStats>
{
	@Query('select * from player_stats where gameId = :gameId order by score')
	Future<List<PlayerStats>> getList(String gameId);
}