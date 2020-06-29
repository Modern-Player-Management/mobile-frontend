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
		test('insert one teamplayer', insert_teamPlayer);

		test('find one teamplayer', find_teamPlayer);

		test('delete teamplayer', delete_teamPlayer);
	});

	tearDown((){
		_db.close();
	});
}

Future<TeamPlayer> insert_teamPlayer([AppDatabase db]) async
{
	var team = await insert_team(_db);
	var player = await insert_player(_db, team);

	final teamPlayer = TeamPlayer(
		teamId: teamId,
		playerId: playerId
	);

	var id = await (_db ?? db).teamPlayerDao.insertModel(teamPlayer);

	expect(id, equals(1));
}

void find_teamPlayer() async
{
	await insert_teamPlayer();

	final teamPlayer = TeamPlayer(
		teamId: teamId,
		playerId: playerId
	);

	var tps = await _db.teamPlayerDao.getAllTeamPlayers(teamId);

	expect(tps.length, equals(1));
}

void delete_teamPlayer() async
{
	await insert_teamPlayer();

	final teamPlayer = TeamPlayer(
		teamId: teamId,
		playerId: playerId
	);

	var rows = await _db.teamPlayerDao.deleteModel(teamPlayer);

	expect(rows, equals(1));
}