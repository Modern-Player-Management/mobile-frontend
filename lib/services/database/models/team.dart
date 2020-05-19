import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:mpm/services/database/models/user.dart';

part 'team.g.dart';

@Entity(
	tableName: 'teams',
	foreignKeys: [
		ForeignKey(
			childColumns: ['managerId'],
			parentColumns: ['id'],
			entity: User
		)
	]
)
@JsonSerializable()
class Team
{
	@primaryKey
	String id;

	String name;
	String managerId;

	bool save, update, delete;

	@ignore
	User manager;

	@ignore
	List<User> members;

  	Team({
		this.id, 
		this.name,
		String managerId,
		bool save = false,
		bool update = false,
		bool delete = false,
		User manager,
		this.members = const []
	}) : 
		this.managerId = managerId ?? manager?.id,
		this.save = save ?? false,
		this.update = update ?? false,
		this.delete = delete ?? false,
		this.manager = manager;

	static const fromJson = _$TeamFromJson;

	Map<String, dynamic> toJson() 
	{
		return {
			"name": name,
		};
	}
}