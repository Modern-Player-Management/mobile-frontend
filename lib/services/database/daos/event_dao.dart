import 'package:floor/floor.dart';

import 'package:mpm/services/database/daos/model_dao.dart';
import 'package:mpm/services/database/models/event.dart';

@dao
abstract class EventDao extends ModelDao<Event>
{
	@Query('select * from events where id = :id')
	Future<Event> get(String id);

	@Query('select * from events where teamId = :teamId and deleted = 0 ')
	Stream<List<Event>> getStream(String teamId);

	@Query('select * from events where teamId = :teamId and deleted = 0 ')
	Future<List<Event>> getList(String teamId);

	@Query('select * from events where teamId = :teamId '
		'and saved = 1 and deleted = 0')
	Future<List<Event>> getSaved(String teamId);

	@Query('select * from events where teamId = :teamId '
		'and saved = 0 and deleted = 0')
	Future<List<Event>> getUnsaved(String teamId);

	@Query('select * from events where teamId = :teamId and deleted = 1')
	Future<List<Event>> getUndeleted(String teamId);
}