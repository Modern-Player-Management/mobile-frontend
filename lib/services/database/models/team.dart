import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:mpm/app/locator.dart';
import 'package:mpm/services/database/models/player.dart';

part 'team.g.dart';

@Entity(
	tableName: 'teams',
	foreignKeys: [
		ForeignKey(
			childColumns: ['managerId'],
			parentColumns: ['id'],
			entity: Player,
			onDelete: ForeignKeyAction.cascade,
			onUpdate: ForeignKeyAction.cascade,
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

	String name, description, image;

	String managerId;

	@ignore
	bool isCurrentUserManager;

	@ignore
	Player manager;

	@ignore
	List<Player> players;

	String created;

	@JsonKey(ignore: true)
	bool save;
	@JsonKey(ignore: true)
	bool update;
	@JsonKey(ignore: true)
	bool delete;

  	Team({
		this.id, 
		this.name,
		this.description,
		this.image,
		this.player,
		String managerId,
		this.isCurrentUserManager,
		Player manager,
		List<Player> players,
		bool save = false,
		bool update = false,
		bool delete = false,
	}) : 
		this.managerId = managerId ?? manager?.id,
		this.manager = manager,
		this.players = players ?? [],
		this.save = save ?? false,
		this.update = update ?? false,
		this.delete = delete ?? false;

	static const fromJson = _$TeamFromJson;

	Map<String, dynamic> toJson() 
	{
		return {
			"name": name,
			"description": description,
			"image": image
		};
	}
}