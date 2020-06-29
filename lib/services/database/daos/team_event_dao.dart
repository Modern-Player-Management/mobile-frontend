import 'package:floor/floor.dart';

import 'package:mpm/services/database/daos/model_dao.dart';
import 'package:mpm/services/database/models/team_event.dart';

@dao
abstract class TeamEventDao extends ModelDao<TeamEvent>
{
	@Query('select * from team_events where teamId = :teamId and deleted = 0')
	Stream<List<TeamEvent>> getTeamEvents(String teamId);

	@Query('select * from team_events where teamId = :teamId and deleted = 0')
	Future<List<TeamEvent>> getAllTeamEvents(String teamId);

	@Query('select * from team_events where teamId = :teamId and saved = 1 and deleted = 0')
	Future<List<TeamEvent>> getSavedTeamEvents(String teamId);

	@Query('select * from team_events where teamId = :teamId and saved = 0 and deleted = 0')
	Future<List<TeamEvent>> getUnsavedTeamEvents(String teamId);

	@Query('select * from team_events where teamId = :teamId and deleted = 1')
	Future<List<TeamEvent>> getUndeletedTeamEvents(String teamId);
}