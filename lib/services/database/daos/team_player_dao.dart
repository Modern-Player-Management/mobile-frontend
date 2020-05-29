import 'package:floor/floor.dart';

import 'package:mpm/services/database/models/team_player.dart';

@dao
abstract class TeamPlayerDao
{
	@Query('select * from teams_players where teamId = :teamId and `delete` = 0')
	Future<List<TeamPlayer>> getTeamPlayers(String teamId);

	@Query('select * from teams_players where teamId = :teamId and save = 1 and `delete` = 0')
	Future<List<TeamPlayer>> getSavedTeamPlayers(String teamId);

	@Query('select * from teams_players where teamId = :teamId and save = 0 and `delete` = 0')
	Future<List<TeamPlayer>> getUnsavedTeamPlayers(String teamId);

	@Query('select * from teams_players where teamId = :teamId and `delete` = 1')
	Future<List<TeamPlayer>> getUndeletedTeamPlayers(String teamId);

	@Query('select * from teams_players where teamId = :teamId and playerId = :playerId')
	Future<TeamPlayer> getTeamPlayer(String teamId, String playerId);

	@Insert(
		onConflict: OnConflictStrategy.REPLACE
	)
	Future<int> insertTeamPlayer(TeamPlayer teamPlayer);

	@update
	Future<int> updateTeamPlayer(TeamPlayer teamPlayer);

	@delete
	Future<int> deleteTeamPlayer(TeamPlayer teamPlayer);
}