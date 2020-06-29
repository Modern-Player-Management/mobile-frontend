import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:sqflite_ffi_test/sqflite_ffi_test.dart';

import 'package:mpm/services/database/database.dart';

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

	group('simple database player tests', (){
		
		test('insert one player', insert_player);
		test('find one player', find_player);
		test('update player', update_player);
		test('delete player', delete_player);
	});

	tearDown((){
		_db.close();
	});
}

Future<Player> insert_player([AppDatabase db, Team team]) async
{
	if(team == null) 
	{
		await insert_team(_db);
	}

	final player = Player(
		id: playerId,
		email: email,
		username: username,
	);

	int id = await (_db ?? db).playerDao.insertModel(player);

	expect(id, equals(1));

	return player;
}

void find_player() async
{
	await insert_player();

	final player = await _db.playerDao.getPlayer(playerId);

	expect(player.id, equals(playerId));
}

void update_player() async
{
	final player = await insert_player();

	player.username = "test";
	int rows = await _db.playerDao.updateModel(player);

	expect(rows, equals(1));

	final p = await _db.playerDao.getPlayer(playerId);

	expect(p.username, equals("test"));
}

void delete_player() async
{
	final player = await insert_player();

	var rows = await _db.playerDao.deleteModel(player);

	expect(rows, equals(1));

	final p = await _db.playerDao.getPlayer(playerId);

	expect(p, equals(null));
}