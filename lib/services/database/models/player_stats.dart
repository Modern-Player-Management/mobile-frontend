import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:mpm/services/database/models/game.dart';

part 'player_stats.g.dart';

@Entity(
	tableName: 'player_stats',
	foreignKeys: [
		ForeignKey(
			childColumns: ['gameId'],
			parentColumns: ['id'],
			entity: Game,
			onDelete: ForeignKeyAction.cascade,
			onUpdate: ForeignKeyAction.cascade
		)
	]
)
@JsonSerializable()
class PlayerStats
{
	@primaryKey
	String id;

	String player;
	
	int goals, saves, shots, assists, score, goalShots;

	String created;

	@JsonKey(ignore: true)
	String gameId;

	@JsonKey(ignore: true)
	bool saved;
	@JsonKey(ignore: true)
	bool create;
	@JsonKey(ignore: true)
	bool deleted;

	PlayerStats({
		this.id,
		this.player,
		this.goals, 
		this.saves, 
		this.shots, 
		this.assists, 
		this.score, 
		this.goalShots,
		this.created,
		this.gameId,
		bool saved = false,
		bool create = false,
		bool deleted = false,
	}) :
		this.saved = saved ?? false,
		this.create = create ?? false,
		this.deleted = deleted ?? false;

	static const fromJson = _$PlayerStatsFromJson;
}