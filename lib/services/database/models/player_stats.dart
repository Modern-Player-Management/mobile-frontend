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
	});

	static const fromJson = _$PlayerStatsFromJson;

	DateTime get date => DateTime.parse(created);
}