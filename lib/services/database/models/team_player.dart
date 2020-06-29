import 'package:floor/floor.dart';

import 'package:mpm/app/locator.dart';
import 'package:mpm/services/database/models/models.dart';

@Entity(
	tableName: 'team_players',
	primaryKeys: ['teamId', 'playerId'],
	foreignKeys: [
		ForeignKey(
			childColumns: ['teamId'],
			parentColumns: ['id'],
			entity: Team,
			onDelete: ForeignKeyAction.cascade,
			onUpdate: ForeignKeyAction.cascade,
		),
		ForeignKey(
			childColumns: ['playerId'],
			parentColumns: ['id'],
			entity: Player,
			onDelete: ForeignKeyAction.cascade,
			onUpdate: ForeignKeyAction.cascade,
		),
	],
)
class TeamPlayer
{
	final String teamId;
	final String playerId;

	bool save, delete;

  	TeamPlayer({
		this.teamId, 
		this.playerId,
		bool save = false,
		bool delete = false,
	}) : 
		this.save = save ?? false,
		this.delete = delete ?? false;
}