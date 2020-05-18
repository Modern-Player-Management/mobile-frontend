import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';

import 'package:mpm/services/database/database.dart';

import '../database_test.dart';

String teamId = "id";
String user = "user";

Future<Team> insert_team() async
{
	final team = Team(
		id: teamId,
		user: user,
		name: "name"
	);

	int id = await db.teamDao.insertTeam(team);

	expect(id, equals(1));

	return team;
}

void find_team() async
{
	await insert_team();

	final teams = await db.teamDao.getTeams(user).first;

	expect(teams.length, equals(1));
}

void update_team() async
{
	final team = await insert_team();

	team.name = "test";
	int rows = await db.teamDao.updateTeam(team);

	expect(rows, equals(1));

	final teams = await db.teamDao.getTeams(user).first;

	expect(teams[0].name, equals("test"));
}

void delete_team() async
{
	final team = await insert_team();

	await db.teamDao.deleteTeam(team);

	final teams = await db.teamDao.getTeams(user).first;

	expect(teams.length, equals(0));
}