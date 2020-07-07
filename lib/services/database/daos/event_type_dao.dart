import 'package:floor/floor.dart';

import 'package:mpm/services/database/daos/model_dao.dart';
import 'package:mpm/services/database/models/event_type.dart';

@dao
abstract class EventTypeDao extends ModelDao<EventType>
{
	@Query('select * from event_types')
	Future<List<EventType>> get();
}