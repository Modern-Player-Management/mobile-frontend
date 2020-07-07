import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mpm/app/locator.dart';

import 'package:mpm/services/database/models/participation.dart';
import 'package:mpm/services/database/models/discrepancy.dart';

part 'event.g.dart';

@Entity(
	tableName: 'events',
	foreignKeys: [
		ForeignKey(
			childColumns: ['teamId'],
			parentColumns: ['id'],
			entity: Team,
			onDelete: ForeignKeyAction.cascade,
			onUpdate: ForeignKeyAction.cascade
		)
	]
)
@JsonSerializable()
class Event 
{
	@primaryKey
	String id;

	@JsonKey(ignore: true)
	String teamId;

	String start, end;
	String name, description;

	int type;

	bool currentHasConfirmed;
	
	@JsonKey(ignore: true)
	bool saved;
	@JsonKey(ignore: true)
	bool create;
	@JsonKey(ignore: true)
	bool deleted;

	@ignore
	List<Participation> participations;

	@ignore
	List<Discrepancy> discrepancies;

	DateTime get startDate {
		if(start != null && start.isNotEmpty)
		{
			return DateTime.parse(start);
		}

		return null;
	}

	DateTime get endDate {
		if(end != null && end.isNotEmpty)
		{
			return DateTime.parse(end);
		}

		return null;
	}

  	Event({
		this.id, 
		this.teamId,
		this.start, 
		this.end,
		this.name, 
		this.description,
		this.type,
		this.currentHasConfirmed,
		this.participations,
		this.discrepancies,
		bool saved = false,
		bool create = false,
		bool deleted = false,
	}) : 
		this.saved = saved ?? false,
		this.create = create ?? false,
		this.deleted = deleted ?? false;

	static const fromJson = _$EventFromJson;

	Map<String, dynamic> toJson() 
	{
		return {
			"start": start,
			"end": end,
			"name": name,
			"description": description,
			"type": type
		};
	}
}