import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'player_stats.g.dart';

@Entity(
	tableName: 'player_stats',
)
@JsonSerializable()
class PlayerStats
{
	@primaryKey
	String id;

	String player;
	
	int goals, saves, shots, assists, score, goalShots;

	String created;

	PlayerStats({
		this.id,
		this.player,
		this.goals, 
		this.saves, 
		this.shots, 
		this.assists, 
		this.score, 
		this.goalShots,
		this.created
	});

	static const fromJson = _$PlayerStatsFromJson;
}