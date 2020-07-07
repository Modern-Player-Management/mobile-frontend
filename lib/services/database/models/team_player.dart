import 'package:floor/floor.dart';

@Entity(
	tableName: 'team_players',
	primaryKeys: ['teamId', 'playerId'],
	indices: [
		Index(value: ['teamId']),
		Index(value: ['playerId']),
	]
)
class TeamPlayer
{
	final String teamId;
	final String playerId;

	bool saved, deleted;

  	TeamPlayer({
		this.teamId, 
		this.playerId,
		bool saved = false,
		bool deleted = false,
	}) : 
		this.saved = saved ?? false,
		this.deleted = deleted ?? false;
}