import 'package:floor/floor.dart';

import 'package:mpm/app/locator.dart';
import 'package:mpm/services/database/models/models.dart';

@Entity(
	tableName: 'events_discrepancies',
	foreignKeys: [
		ForeignKey(
			childColumns: ['eventId'],
			parentColumns: ['id'],
			entity: Event,
			onDelete: ForeignKeyAction.cascade,
			onUpdate: ForeignKeyAction.cascade,
		),
		ForeignKey(
			childColumns: ['discrepancyId'],
			parentColumns: ['id'],
			entity: Discrepancy,
			onDelete: ForeignKeyAction.cascade,
			onUpdate: ForeignKeyAction.cascade,
		),
	]
)
class EventDiscrepancy
{	
	@PrimaryKey(autoGenerate: true)
	final int id;
	
	final String eventId;
	final String discrepancyId;

	bool saved, deleted;

  	EventDiscrepancy({
		this.id, 
		this.eventId, 
		this.discrepancyId,
		bool saved = false,
		bool deleted = false,
	}) : 
		this.saved = saved ?? false,
		this.deleted = deleted ?? false;
}