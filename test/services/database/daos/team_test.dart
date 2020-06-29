import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:sqflite_ffi_test/sqflite_ffi_test.dart';

import 'package:mpm/app/locator.dart';
import 'package:mpm/services/database/database.dart';

String teamId = "team";
String teamName = "name";
String player = "player";

String managerId = "manager";
String managerEmail = "manager@manager.fr";
String managerUsername = "manager";

AppDatabase _db;

void main()
{
	TestWidgetsFlutterBinding.ensureInitialized();
	sqfliteFfiTestInit();

	setUp(() async {
		await configure(true);
		_db = locator<AppDatabase>();
	});

	group('simple database team tests', (){
		
		test('insert one team', insertTeam);
		test('find one team', findTeam);
		test('update team', updateTeam);
		test('delete team', deleteTeam);
	});

	group('more database team tests', (){
		test('team with manager', teamWithManager);
	});

	tearDown((){
		_db.close();
	});
}

Future<Team> insertTeam([AppDatabase db]) async
{
	final team = Team(
		id: teamId,
		player: player,
		name: teamName
	);

	int id = await (_db ?? db).teamDao.insertModel(team);

	expect(id, equals(1));

	return team;
}

Future<Team> findTeam() async
{
	await insertTeam();

	final teams = await _db.teamDao.getTeams(player).first;

	expect(teams.length, equals(1));

	return teams[0];
}

void updateTeam() async
{
	var team = await insertTeam();
	
	team.name = "test";
	int rows = await _db.teamDao.updateModel(team);

	expect(rows, equals(1));

	final teams = await _db.teamDao.getTeams(player).first;

	expect(teams[0].name, equals("test"));
}

void deleteTeam() async
{
	var team = await insertTeam();
	var rows = await _db.teamDao.deleteModel(team);

	expect(rows, equals(1));

	final teams = await _db.teamDao.getTeams(player).first;

	expect(teams.length, equals(0));
}

void teamWithManager() async
{
	final manager = Player(
		id: managerId,
		email: managerEmail,
		username: managerUsername
	);

	var id = await _db.playerDao.insertModel(manager);

	expect(id, equals(1));

	final team = Team(
		id: teamId,
		player: player,
		name: teamName,
		managerId: managerId
	);

	id = await _db.teamDao.insertModel(team);

	expect(id, equals(1));
}