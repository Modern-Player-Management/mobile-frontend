import 'package:floor/floor.dart';

import 'package:mpm/services/database/models/team.dart';

@dao
abstract class TeamDao
{
	@Query('select * from teams where player = :player and `delete` = 0')
	Stream<List<Team>> getTeams(String player);

	@Query('select * from teams where player = :player and save = 1 and `delete` = 0')
	Future<List<Team>> getSavedTeams(String player);

	@Query('select * from teams where player = :player and save = 0 and `delete` = 0')
	Future<List<Team>> getUnsavedTeams(String player);

	@Query('select * from teams where player = :player and `delete` = 1')
	Future<List<Team>> getUndeletedTeams(String player);

	@insert
	Future<int> insertTeam(Team team);

	@update
	Future<int> updateTeam(Team team);

	@delete
	Future<int> deleteTeam(Team team);
}