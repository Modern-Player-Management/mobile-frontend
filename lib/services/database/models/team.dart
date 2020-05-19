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
	],
	indices: [
		Index(
			value: ['user']
		)
	]
)
@JsonSerializable()
class Team
{
	@primaryKey
	String id;
	
	// index
	String user;

	String name, managerId;

	@ignore
	bool isCurrentUserManager;

	@ignore
	User manager;

	@ignore
	List<User> members;

	bool save, update, delete;

  	Team({
		this.id, 
		this.name,
		this.user,
		String managerId,
		this.isCurrentUserManager,
		User manager,
		this.members = const [],
		bool save = false,
		bool update = false,
		bool delete = false,
	}) : 
		this.managerId = managerId ?? manager?.id,
		this.manager = manager,
		this.save = save ?? false,
		this.update = update ?? false,
		this.delete = delete ?? false;

	static const fromJson = _$TeamFromJson;

	Map<String, dynamic> toJson() 
	{
		return {
			"name": name,
		};
	}
}