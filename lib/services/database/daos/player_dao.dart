import 'package:floor/floor.dart';

import 'package:mpm/services/database/daos/model_dao.dart';
import 'package:mpm/services/database/models/player.dart';

@dao
abstract class PlayerDao extends ModelDao<Player>
{
	@Query('select * from players where id in (:ids)')
	Stream<List<Player>> getPlayers(List<String> ids);

	@Query('select * from players where id = :id')
	Future<Player> getPlayer(String id);

	@Query('update players set id = :newId where id = :oldId')
	Future<void> updatePlayerId(String oldId, String newId);
}