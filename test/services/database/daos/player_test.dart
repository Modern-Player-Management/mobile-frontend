import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:sqflite_ffi_test/sqflite_ffi_test.dart';

import 'package:mpm/app/locator.dart';
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
		await configure(true);
		_db = locator<AppDatabase>();
	});

	group('simple database player tests', (){
		
		test('insert one player', insertPlayer);
		test('find one player', findPlayer);
		test('update player', updatePlayer);
		test('delete player', deletePlayer);
	});

	tearDown((){
		_db.close();
	});
}

Future<Player> insertPlayer([AppDatabase db, Team team]) async
{
	if(team == null) 
	{
		await insertTeam(_db);
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

void findPlayer() async
{
	await insertPlayer();

	final player = await _db.playerDao.get(playerId);

	expect(player.id, equals(playerId));
}

void updatePlayer() async
{
	final player = await insertPlayer();

	player.username = "test";
	int rows = await _db.playerDao.updateModel(player);

	expect(rows, equals(1));

	final p = await _db.playerDao.get(playerId);

	expect(p.username, equals("test"));
}

void deletePlayer() async
{
	final player = await insertPlayer();

	var rows = await _db.playerDao.deleteModel(player);

	expect(rows, equals(1));

	final p = await _db.playerDao.get(playerId);

	expect(p, equals(null));
}