import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:mpm/services/database/models/player_stats.dart';
import 'package:mpm/services/database/models/team.dart';

part 'game.g.dart';

@Entity(
	tableName: 'games',
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
class Game
{
	@primaryKey
	String id;

	String name, date;
	int win;

	@ignore
	List<PlayerStats> playerStats;

	@JsonKey(ignore: true)
	String teamId;

	@JsonKey(ignore: true)
	bool saved;
	@JsonKey(ignore: true)
	bool create;
	@JsonKey(ignore: true)
	bool deleted;

	bool get isWin => win == 1;

	Game({
		this.id,
		this.name,
		this.date,
		this.win,
		this.playerStats,
		this.teamId,
		bool saved = false,
		bool create = false,
		bool deleted = false,
	}) :
		this.saved = saved ?? false,
		this.create = create ?? false,
		this.deleted = deleted ?? false;

	static const fromJson = _$GameFromJson;
}