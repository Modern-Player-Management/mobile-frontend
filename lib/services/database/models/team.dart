import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:mpm/app/locator.dart';
import 'package:mpm/services/database/models/player.dart';

part 'team.g.dart';

@Entity(
	tableName: 'teams',
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
	bool saved;
	@JsonKey(ignore: true)
	bool create;
	@JsonKey(ignore: true)
	bool deleted;

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
		bool saved = false,
		bool create = false,
		bool deleted = false,
	}) : 
		this.managerId = managerId ?? manager?.id,
		this.manager = manager,
		this.players = players ?? [],
		this.saved = saved ?? false,
		this.create = create ?? false,
		this.deleted = deleted ?? false;

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