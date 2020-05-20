import 'package:flutter/material.dart';

import 'package:chopper/chopper.dart';
import 'package:injectable/injectable.dart';

import 'package:mpm/app/locator.dart';

@injectable
class TeamManager
{
	final _api = locator<TeamApi>();
	final _dao = locator<AppDatabase>().teamDao;

	final _storage = locator<SecureStorage>();
	final _uuid = locator<Uuid>();

	final Function(Response) validResponse;

	TeamManager({
		@required @factoryParam Function validResponse
	}) : this.validResponse = validResponse;

	Future<void> syncTeams(List<Team> teams) async
	{
		var savedTeams = await _dao.getSavedTeams(_storage.player);
		var teamsKey = [
			for(var team in savedTeams)
				team.id
		];

		for(var team in teams)
		{
			team.player = _storage.player;
			team.save = true;
			_dao.insertTeam(team);

			int index = teamsKey.indexOf(team.id);
			if(index != -1)
			{
				savedTeams.removeAt(index);
				teamsKey.removeAt(index);
			}

			//await modulesManager.syncModules(team, team.modules);
		}

		for(var team in savedTeams) {
			_dao.deleteTeam(team);
		}
	}

	Stream<List<Team>> getTeams()
	{
		return _dao.getTeams(_storage.player);
	}

	Future<void> insertTeam(Team team, [bool add = true]) async
	{
		if(add) 
		{
			team.id = _uuid.v1();
			team.player = _storage.player;
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
				team.player = _storage.player;
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

	Future<void> addUser(Team team, Player player) async
	{
		
	}

	Future<void> removeUser(Team team, Player player) async
	{
		
	}
}