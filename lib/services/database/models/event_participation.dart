import 'package:floor/floor.dart';

import 'package:mpm/app/locator.dart';
import 'package:mpm/services/database/models/event.dart';
import 'package:mpm/services/database/models/participation.dart';

@Entity(
	tableName: 'events_participations',
	foreignKeys: [
		ForeignKey(
			childColumns: ['eventId'],
			parentColumns: ['id'],
			entity: Event,
			onDelete: ForeignKeyAction.cascade,
			onUpdate: ForeignKeyAction.cascade,
		),
		ForeignKey(
			childColumns: ['participationId'],
			parentColumns: ['id'],
			entity: Participation,
			onDelete: ForeignKeyAction.cascade,
			onUpdate: ForeignKeyAction.cascade,
		),
	]
)
class EventParticipation
{	
	@PrimaryKey(autoGenerate: true)
	final int id;
	
	final String eventId;
	final String participationId;

	bool saved, deleted;

  	EventParticipation({
		this.id, 
		this.eventId, 
		this.participationId,
		bool saved = false,
		bool deleted = false,
	}) : 
		this.saved = saved ?? false,
		this.deleted = deleted ?? false;
}