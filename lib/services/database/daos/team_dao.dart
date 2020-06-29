import 'package:floor/floor.dart';

import 'package:mpm/app/locator.dart';
import 'package:mpm/services/database/daos/model_dao.dart';

@dao
abstract class TeamDao extends ModelDao<Team>
{
	@Query('select * from teams where player = :player and `delete` = 0 order by name')
	Stream<List<Team>> getTeams(String player);

	@Query('select * from teams where player = :player and save = 1 and `delete` = 0')
	Future<List<Team>> getSavedTeams(String player);

	@Query('select * from teams where player = :player and save = 0 and `delete` = 0')
	Future<List<Team>> getUnsavedTeams(String player);

	@Query('select * from teams where player = :player and `delete` = 1')
	Future<List<Team>> getUndeletedTeams(String player);

	@Query('update teams set id = :newId, save = :save where id = :oldId')
	Future<void> updateTeamId(String oldId, String newId, int save);

	Future<Player> getManager(Team team) async
	{
		final _playerDao = locator<AppDatabase>().playerDao;
		return await _playerDao.getPlayer(team.managerId);
	}

	Stream<List<Player>> getPlayers(Team team) async *
	{
		final _teamPlayerDao = locator<AppDatabase>().teamPlayerDao;
		final _playerDao = locator<AppDatabase>().playerDao;
		await for(var teamPlayers in _teamPlayerDao.getTeamPlayers(team.id))
		{
			List<Player> players = [];
			for(var teamPlayer in teamPlayers)
			{
				if(teamPlayer.playerId != team.managerId)
				{
					players.add(await _playerDao.getPlayer(teamPlayer.playerId));
				}
			}

			yield players;
		}
	}

	Future<List<Player>> getAllPlayers(Team team) async
	{
		final _teamPlayerDao = locator<AppDatabase>().teamPlayerDao;
		final _playerDao = locator<AppDatabase>().playerDao;
		List<Player> players = [];
		for(var teamPlayer in await _teamPlayerDao.getAllTeamPlayers(team.id))
		{

			if(teamPlayer.playerId != team.managerId)
			{
				players.add(await _playerDao.getPlayer(teamPlayer.playerId));
			}
		}

		return players;
	}

	Stream<List<Event>> getEvents(Team team) async *
	{
		yield [];
	}
}