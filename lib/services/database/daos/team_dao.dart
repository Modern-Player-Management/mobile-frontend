import 'package:floor/floor.dart';

import 'package:mpm/services/database/daos/model_dao.dart';
import 'package:mpm/services/database/models/team.dart';

@dao
abstract class TeamDao extends ModelDao<Team>
{
	@Query('select * from teams where player = :player and `deleted` = 0 order by name')
	Stream<List<Team>> getTeams(String player);

	@Query('select * from teams where player = :player and `deleted` = 0 order by name')
	Future<List<Team>> getAllTeams(String player);

	@Query('select * from teams where player = :player and saved = 1 and delete = 0')
	Future<List<Team>> getSavedTeams(String player);

	@Query('select * from teams where player = :player and saved = 0 and deleted = 0')
	Future<List<Team>> getUnsavedTeams(String player);

	@Query('select * from teams where player = :player and deleted = 1')
	Future<List<Team>> getUndeletedTeams(String player);

	@Query('update teams set id = :newId, save = :save where id = :oldId')
	Future<void> updateTeamId(String oldId, String newId, int save);
}