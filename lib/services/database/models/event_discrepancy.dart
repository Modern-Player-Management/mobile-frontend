import 'package:floor/floor.dart';

import 'package:mpm/app/locator.dart';
import 'package:mpm/services/database/models/models.dart';

@Entity(
	tableName: 'events_discrepancies',
	foreignKeys: [
		ForeignKey(
			childColumns: ['eventId'],
			parentColumns: ['id'],
			entity: Event
		),
		ForeignKey(
			childColumns: ['discrepancyId'],
			parentColumns: ['id'],
			entity: Discrepancy
		),
	]
)
class EventDiscrepancy
{	
	@PrimaryKey(autoGenerate: true)
	final int id;
	
	final String eventId;
	final String discrepancyId;

	bool save, delete;

  	EventDiscrepancy({
		this.id, 
		this.eventId, 
		this.discrepancyId,
		bool save = false,
		bool delete = false,
	}) : 
		this.save = save ?? false,
		this.delete = delete ?? false;
}