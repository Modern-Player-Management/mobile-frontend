import 'package:chopper/chopper.dart';

import 'package:mpm/app/locator.dart';

class TeamManager
{
	final Function(Response) validResponse;

	final _api = locator<TeamApi>();
	final _dao = locator<AppDatabase>().teamDao;

	final _storage = locator<SecureStorage>();
	final _uuid = locator<Uuid>();

	TeamManager({
		this.validResponse
	});

	Stream<List<Team>> getTeams()
	{
		return _dao.getTeams(_storage.user);
	}

	Future<void> insertTeam(Team team, [bool add = true]) async
	{
		if(add) 
		{
			team.id = _uuid.v1();
			team.user = _storage.user;
			team.save = true;

			await _dao.insertTeam(team);
		}

		try
		{
			var response = await _api.createTeam(team);
			if(validResponse(response))
			{
				await _dao.deleteTeam(team);

				team = response.body;
				team.user = _storage.user;
				team.save = true;
				await _dao.insertTeam(team);
			}
		}
		catch(e) {
			print(e);
		}
	}

	Future<void> updateTeam(Team team) async
	{
		await _dao.updateTeam(team);

		try
		{
			var response = await _api.updateTeam(team.id, team);
			if(validResponse(response)) {
				team.save = true;
				await _dao.updateTeam(team);
			}
		}
		catch(e) {
			print(e);
		}
	}

	Future<void> deleteTeam(Team team) async
	{
		team.delete = true;
		await _dao.updateTeam(team);

		try
		{
			var response = await _api.deleteTeam(team.id);
			if(validResponse(response)) {
				await _dao.deleteTeam(team);
			}
		}
		catch(e) {
			print(e);
		}
	}
}