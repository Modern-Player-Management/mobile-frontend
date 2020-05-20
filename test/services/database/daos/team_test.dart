import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:sqflite_ffi_test/sqflite_ffi_test.dart';

import 'package:mpm/services/database/database.dart';

String teamId = "team";
String player = "player";

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

	tearDown((){
		_db.close();
	});
}

Future<Team> insert_team([AppDatabase db]) async
{
	final team = Team(
		id: teamId,
		player: player,
		name: "name"
	);

	int id = await (_db ?? db).teamDao.insertTeam(team);

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
	int rows = await _db.teamDao.updateTeam(team);

	expect(rows, equals(1));

	final teams = await _db.teamDao.getTeams(player).first;

	expect(teams[0].name, equals("test"));
}

void delete_team() async
{
	final team = await insert_team();

	await _db.teamDao.deleteTeam(team);

	final teams = await _db.teamDao.getTeams(player).first;

	expect(teams.length, equals(0));
}