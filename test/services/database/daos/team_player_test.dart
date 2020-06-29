import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:sqflite_ffi_test/sqflite_ffi_test.dart';

import 'package:mpm/services/database/database.dart';

import 'player_test.dart';
import 'team_test.dart';

String playerId = "player";
String email = "test@test.fr";
String username = "username";

AppDatabase _db;

void main()
{
	TestWidgetsFlutterBinding.ensureInitialized();
	sqfliteFfiTestInit();

	setUp(() async {
		_db = await $FloorAppDatabase.inMemoryDatabaseBuilder().build();
	});

	group('simple database teamplayer tests', (){
		test('insert one teamplayer', insertTeamPlayer);

		test('find one teamplayer', findTeamPlayer);

		test('delete teamplayer', deleteTeamPlayer);
	});

	tearDown((){
		_db.close();
	});
}

Future<TeamPlayer> insertTeamPlayer([AppDatabase db]) async
{
	var team = await insertTeam(_db);
	var player = await insertPlayer(_db, team);

	final teamPlayer = TeamPlayer(
		teamId: team.id,
		playerId: player.id
	);

	var id = await (_db ?? db).teamPlayerDao.insertModel(teamPlayer);

	expect(id, equals(1));

	return teamPlayer;
}

void findTeamPlayer() async
{
	await insertTeamPlayer();

	var tps = await _db.teamPlayerDao.getAllTeamPlayers(teamId);

	expect(tps.length, equals(1));
}

void deleteTeamPlayer() async
{
	await insertTeamPlayer();

	final teamPlayer = TeamPlayer(
		teamId: teamId,
		playerId: playerId
	);

	var rows = await _db.teamPlayerDao.deleteModel(teamPlayer);

	expect(rows, equals(1));
}