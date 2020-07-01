import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:mpm/services/database/models/participation.dart';
import 'package:mpm/services/database/models/discrepancy.dart';

part 'event.g.dart';

@Entity(
	tableName: 'events',
)
@JsonSerializable()
class Event 
{
	@primaryKey
	String id;

	String team;

	String start, end;
	String name, description; 

	int type;

	@ignore
	List<Participation> participations;

	@ignore
	List<Discrepancy> discrepancies;

  	Event({
		this.id, 
		this.team,
		this.start, 
		this.end,
		this.name, 
		this.description,
		this.type,
		this.participations,
		this.discrepancies,
	});

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