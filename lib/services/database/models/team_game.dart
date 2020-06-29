import 'package:floor/floor.dart';

import 'package:mpm/app/locator.dart';
import 'package:mpm/services/database/models/models.dart';

@Entity(
	tableName: 'team_games',
	primaryKeys: ['teamId', 'gameId'],
	foreignKeys: [
		ForeignKey(
			childColumns: ['teamId'],
			parentColumns: ['id'],
			entity: Team,
			onDelete: ForeignKeyAction.cascade,
			onUpdate: ForeignKeyAction.cascade,
		),
		ForeignKey(
			childColumns: ['gameId'],
			parentColumns: ['id'],
			entity: Game,
			onDelete: ForeignKeyAction.cascade,
			onUpdate: ForeignKeyAction.cascade,
		),
	],
)
class TeamGame
{
	final String teamId;
	final String gameId;

	bool saved, deleted;

  	TeamGame({
		this.teamId, 
		this.gameId,
		bool saved = false,
		bool deleted = false,
	}) : 
		this.saved = saved ?? false,
		this.deleted = deleted ?? false;
}