import 'package:floor/floor.dart';

import 'package:mpm/services/database/models/models.dart';

@Entity(
	tableName: 'teams_users',
	foreignKeys: [
		ForeignKey(
			childColumns: ['team'],
			parentColumns: ['id'],
			entity: Team
		),
		ForeignKey(
			childColumns: ['user'],
			parentColumns: ['id'],
			entity: User
		),
	]
)
class TeamUser
{	
	@PrimaryKey(autoGenerate: true)
	final int id;
	
	final String team;
	final String user;

  	TeamUser({
		this.id, 
		this.team, 
		this.user
	});
}