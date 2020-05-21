import 'package:floor/floor.dart';

import 'package:mpm/services/database/models/player.dart';

@dao
abstract class PlayerDao
{
	@Query('select * from players where id in (:ids)')
	Stream<List<Player>> getPlayers(List<String> ids);

	@Query('select * from players where id = :id')
	Future<Player> getPlayer(String id);

	@insert
	Future<int> insertPlayer(Player player);

	@update
	Future<int> updatePlayer(Player player);

	@Query('update players set id = :newId where id = :oldId')
	Future<void> updatePlayerId(String oldId, String newId);

	@delete
	Future<int> deletePlayer(Player player);
}