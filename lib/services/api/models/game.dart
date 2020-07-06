import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:mpm/services/database/models/player_stats.dart';

part 'game.g.dart';

@Entity(
	tableName: 'games',
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

	Game({
		this.id,
		this.name,
		this.date,
		this.win,
		this.playerStats
	});

	static const fromJson = _$GameFromJson;
}