import 'package:floor/floor.dart';

import 'package:mpm/services/database/models/player.dart';

@dao
abstract class PlayerDao
{
	@Query('select * from players `delete` = 0')
	Stream<List<Player>> getPlayers();

	@Query('select * from players save = 1 and `delete` = 0')
	Future<List<Player>> getSavedPlayers();

	@Query('select * from players save = 0 and `delete` = 0')
	Future<List<Player>> getUnsavedPlayers();

	@Query('select * from players `delete` = 1')
	Future<List<Player>> getUndeletedPlayers();

	@insert
	Future<int> insertPlayer(Player player);

	@update
	Future<int> updatePlayer(Player player);

	@delete
	Future<int> deletePlayer(Player player);
}