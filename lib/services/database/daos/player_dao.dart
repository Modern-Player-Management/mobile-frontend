import 'package:floor/floor.dart';

import 'package:mpm/app/locator.dart';
import 'package:mpm/services/database/daos/model_dao.dart';

@dao
abstract class PlayerDao extends ModelDao<Player>
{
	@Query('select * from players where id = :id')
	Future<Player> get(String id);

	@Query('update players set id = :newId where id = :oldId')
	Future<void> updateId(String oldId, String newId);

	@Query('select * from players p inner join team_players tp on p.id = tp.playerId '
		'and tp.teamId = :teamId and tp.playerId != :managerId and tp.deleted = 0')
	Stream<List<Player>> getStream(String teamId, String managerId);

	@Query('select * from players inner join team_players on players.id = team_players.playerId '
		'and team_players.teamId = :teamId and team_players.playerId != :managerId and team_players.deleted = 0')
	Future<List<Player>> getList(String teamId, String managerId);
}