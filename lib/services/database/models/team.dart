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
	@JsonKey(name: "memberships")
	List<Player> players;

	bool save, update, delete;

	@ignore
	@JsonKey(ignore: true)
	bool loaded = false;

  	Team({
		this.id, 
		this.name,
		this.player,
		String managerId,
		this.isCurrentUserManager,
		Player manager,
		this.players = const [],
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

	Future<void> load() async
	{
		var db = locator<AppDatabase>();

		var teamPlayers = await db.teamPlayerDao.getTeamPlayers(id);
		for(var teamPlayer in teamPlayers)
		{
			var player = await db.playerDao.getPlayer(teamPlayer.playerId);
			if(teamPlayer.playerId == managerId)
			{
				manager = player;
			}
			else
			{
				players.add(player);
			}
		}

		loaded = true;
	}
}