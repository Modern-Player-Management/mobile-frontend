import 'package:floor/floor.dart';

import 'package:mpm/services/database/models/event.dart';
import 'package:mpm/services/database/models/team.dart';

@Entity(
	tableName: 'team_events',
	primaryKeys: ['teamId', 'playerId'],
	foreignKeys: [
		ForeignKey(
			childColumns: ['teamId'],
			parentColumns: ['id'],
			entity: Team,
			onDelete: ForeignKeyAction.cascade,
			onUpdate: ForeignKeyAction.cascade,
		),
		ForeignKey(
			childColumns: ['eventId'],
			parentColumns: ['id'],
			entity: Event,
			onDelete: ForeignKeyAction.cascade,
			onUpdate: ForeignKeyAction.cascade,
		),
	],
)
class TeamEvent
{
	final String teamId;
	final String eventId;

	bool saved, deleted;

  	TeamEvent({
		this.teamId, 
		this.eventId,
		bool saved = false,
		bool deleted = false,
	}) : 
		this.saved = saved ?? false,
		this.deleted = deleted ?? false;
}