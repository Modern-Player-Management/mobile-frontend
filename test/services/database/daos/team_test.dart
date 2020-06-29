import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:sqflite_ffi_test/sqflite_ffi_test.dart';

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
		_db = await $FloorAppDatabase.inMemoryDatabaseBuilder().build();
	});

	group('simple database team tests', (){
		
		test('insert one team', insert_team);
		test('find one team', find_team);
		test('update team', update_team);
		test('delete team', delete_team);
	});

	group('more database team tests', (){
		test('team with manager', team_with_manager);
	});

	tearDown((){
		_db.close();
	});
}

Future<Team> insert_team([AppDatabase db]) async
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

void find_team() async
{
	await insert_team();

	final teams = await _db.teamDao.getTeams(player).first;

	expect(teams.length, equals(1));
}

void update_team() async
{
	final team = await insert_team();

	team.name = "test";
	int rows = await _db.teamDao.updateModel(team);

	expect(rows, equals(1));

	final teams = await _db.teamDao.getTeams(player).first;

	expect(teams[0].name, equals("test"));
}

void delete_team() async
{
	final team = await insert_team();

	var rows = await _db.teamDao.deleteModel(team);

	expect(rows, equals(1));

	final teams = await _db.teamDao.getTeams(player).first;

	expect(teams.length, equals(0));
}

void team_with_manager() async
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