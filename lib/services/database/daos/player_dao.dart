import 'package:floor/floor.dart';

import 'package:mpm/app/locator.dart';
import 'package:mpm/services/database/daos/model_dao.dart';

@dao
abstract class PlayerDao extends ModelDao<Player>
{
	@Query('select * from players where id = :id')
	Future<Player> getPlayer(String id);

	@Query('update players set id = :newId where id = :oldId')
	Future<void> updatePlayerId(String oldId, String newId);

	@Query('select * from players inner join team_players on players.id = team_players.playerId '
		'and team_players.teamId = :teamId and team_players.playerId != :managerId and `team_players.delete` = 0')
	Stream<List<Player>> getPlayers(String teamId, String managerId);

	@Query('select * from players inner join team_players on players.id = team_players.playerId '
		'and team_players.teamId = :teamId and team_players.playerId != :managerId and `team_players.delete` = 0')
	Future<List<Player>> getAllPlayers(String teamId, String managerId);
}