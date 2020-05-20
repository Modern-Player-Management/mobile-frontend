import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:mpm/services/database/models/player.dart';

part 'team.g.dart';

@Entity(
	tableName: 'teams',
	foreignKeys: [
		ForeignKey(
			childColumns: ['managerId'],
			parentColumns: ['id'],
			entity: Player
		)
	],
	indices: [
		Index(
			value: ['player']
		)
	]
)
@JsonSerializable()
class Team
{
	@primaryKey
	String id;
	
	// index
	String player;

	String name, managerId;

	@ignore
	bool isCurrentUserManager;

	@ignore
	Player manager;

	@ignore
	List<Player> members;

	bool save, update, delete;

  	Team({
		this.id, 
		this.name,
		this.player,
		String managerId,
		this.isCurrentUserManager,
		Player manager,
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