import 'package:floor/floor.dart';

import 'package:mpm/services/database/models/team.dart';

@dao
abstract class TeamDao
{
	@Query('select * from teams where user = :user and `delete` = 0')
	Stream<List<Team>> getTeams(String user);

	@Query('select * from teams where user = :user and save = 1 and `delete` = 0')
	Future<List<Team>> getSavedTeams(String user);

	@Query('select * from teams where user = :user and save = 0 and `delete` = 0')
	Future<List<Team>> getUnsavedTeams(String user);

	@Query('select * from teams where user = :user and `delete` = 1')
	Future<List<Team>> getUndeletedTeams(String user);

	@insert
	Future<int> insertTeam(Team team);

	@update
	Future<int> updateTeam(Team team);

	@delete
	Future<int> deleteTeam(Team team);
}