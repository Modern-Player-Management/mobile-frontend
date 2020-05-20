import 'package:floor/floor.dart';

import 'package:mpm/services/database/models/models.dart';

@Entity(
	tableName: 'teams_playerss',
	foreignKeys: [
		ForeignKey(
			childColumns: ['team'],
			parentColumns: ['id'],
			entity: Team
		),
		ForeignKey(
			childColumns: ['player'],
			parentColumns: ['id'],
			entity: Player
		),
	]
)
class TeamUser
{	
	@PrimaryKey(autoGenerate: true)
	final int id;
	
	final String team;
	final String player;

  	TeamUser({
		this.id, 
		this.team, 
		this.player
	});
}