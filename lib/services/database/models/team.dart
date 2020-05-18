import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:mpm/services/database/models/event.dart';

part 'team.g.dart';

@JsonSerializable()
@Entity(
	tableName: 'teams',
	indices: [
		Index(
			value: ['user']
		)
	]
)
class Team
{
	@primaryKey
	String id;

	String user;

	String name;

	bool save, update, delete;

	@ignore
	List<Event> events;

  	Team({
		this.id, 
		this.user,
		this.name,
		bool save = false,
		bool update = false,
		bool delete = false,
		this.events = const []
	}) : 
		this.save = save ?? false,
		this.update = update ?? false,
		this.delete = delete ?? false;

	static const fromJson = _$TeamFromJson;

	Map<String, dynamic> toJson() 
	{
		return {
			"name": name
		};
	}
}