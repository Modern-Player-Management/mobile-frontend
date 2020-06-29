import 'package:floor/floor.dart';

import 'package:mpm/services/database/daos/model_dao.dart';
import 'package:mpm/services/database/models/team_event.dart';

@dao
abstract class TeamEventDao extends ModelDao<TeamEvent>
{
	@Query('select * from team_events where teamId = :teamId and `delete` = 0')
	Stream<List<TeamEvent>> getTeamEvents(String teamId);

	@Query('select * from team_events where teamId = :teamId and `delete` = 0')
	Future<List<TeamEvent>> getAllTeamEvents(String teamId);

	@Query('select * from team_events where teamId = :teamId and save = 1 and `delete` = 0')
	Future<List<TeamEvent>> getSavedTeamEvents(String teamId);

	@Query('select * from team_events where teamId = :teamId and save = 0 and `delete` = 0')
	Future<List<TeamEvent>> getUnsavedTeamEvents(String teamId);

	@Query('select * from team_events where teamId = :teamId and `delete` = 1')
	Future<List<TeamEvent>> getUndeletedTeamEvents(String teamId);
}