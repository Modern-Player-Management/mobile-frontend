import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:mpm/services/database/models/team.dart';
import 'package:mpm/services/api/models/participation.dart';
import 'package:mpm/services/database/models/discrepancy.dart';

part 'event.g.dart';

@Entity(
	tableName: 'events',
	foreignKeys: [
		ForeignKey(
			childColumns: ['team'],
			parentColumns: ['id'],
			entity: Team,
			onDelete: ForeignKeyAction.CASCADE
		)
	]
)
@JsonSerializable()
class Event 
{
	@primaryKey
	String id;

	String team;

	String start, end;
	String title, description; 

	int type;

	@ignore
	List<Participation> participations;

	@ignore
	List<Discrepancy> discrepancies;

	@JsonKey(ignore: true)
	bool save;
	@JsonKey(ignore: true)
	bool update;
	@JsonKey(ignore: true)
	bool delete;

  	Event({
		this.id, 
		this.team,
		this.start, 
		this.end,
		this.title, 
		this.description,
		this.type,
		this.participations,
		this.discrepancies,
		bool save = false,
		bool update = false,
		bool delete = false
	}) : 
		this.save = save ?? false,
		this.update = update ?? false,
		this.delete = delete ?? false;

	static const fromJson = _$EventFromJson;

	Map<String, dynamic> toJson() 
	{
		return {
			"start": start,
			"end": end,
			"title": title,
			"description": description
		};
	}
}