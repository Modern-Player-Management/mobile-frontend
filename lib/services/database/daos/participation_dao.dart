import 'package:floor/floor.dart';

import 'package:mpm/services/database/daos/model_dao.dart';
import 'package:mpm/services/database/models/participation.dart';

@dao
abstract class ParticipationDao extends ModelDao<Participation>
{
	@Query('select * from participations where id = :id')
	Future<Participation> get(String id);

	@Query('update participations set id = :newId where id = :oldId')
	Future<void> updateId(String oldId, String newId);

	@Query('select * from participations inner join event_participations on '
		'participations.id = event_participations.participationId and '
		'event_participations.eventId = :eventId and `event_participations.deleted` = 0')
	Stream<List<Participation>> getStream(String eventId);

	@Query('select * from participations inner join event_participations on '
		'participations.id = event_participations.participationId and '
		'event_participations.eventId = :eventId and `event_participations.deleted` = 0')
	Future<List<Participation>> getList(String eventId);
}