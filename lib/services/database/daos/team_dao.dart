import 'package:floor/floor.dart';

import 'package:mpm/app/locator.dart';
import 'package:mpm/services/database/daos/model_dao.dart';

@dao
abstract class TeamDao extends ModelDao<Team>
{
	final teamPlayerDao = locator<AppDatabase>().teamPlayerDao;
	final playerDao = locator<AppDatabase>().playerDao;

	@Query('select * from teams where player = :player and `delete` = 0')
	Stream<List<Team>> getTeams(String player);

	@Query('select * from teams where player = :player and save = 1 and `delete` = 0')
	Future<List<Team>> getSavedTeams(String player);

	@Query('select * from teams where player = :player and save = 0 and `delete` = 0')
	Future<List<Team>> getUnsavedTeams(String player);

	@Query('select * from teams where player = :player and `delete` = 1')
	Future<List<Team>> getUndeletedTeams(String player);

	@Query('update teams set id = :newId, save = :save where id = :oldId')
	Future<void> updateTeamId(String oldId, String newId, int save);

	Stream<List<Player>> getPlayers(Team team) async *
	{
		await for(var teamPlayers in teamPlayerDao.getTeamPlayers(team.id))
		{
			List<Player> players = [];
			for(var teamPlayer in teamPlayers)
			{
				if(teamPlayer.playerId != team.managerId)
				{
					players.add(await playerDao.getPlayer(teamPlayer.playerId));
				}
			}

			yield players;
		}
	}

	Stream<List<Event>> getEvents(Team team) async *
	{
		yield [];
	}
}