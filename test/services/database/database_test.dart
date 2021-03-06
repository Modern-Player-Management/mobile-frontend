import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_ffi_test/sqflite_ffi_test.dart';

import 'package:mpm/app/locator.dart';
import 'package:mpm/services/database/database.dart';

import 'daos/team_test.dart';

AppDatabase _db;

void main()
{
	TestWidgetsFlutterBinding.ensureInitialized();
	sqfliteFfiTestInit();

	setUp(() async {
		await configure(true);
		_db = locator<AppDatabase>();
	});

	group('complex database tests', (){
		test('delete team with two players', deleteTeamWithTwoPlayers);
		test('delete team with two events', deleteTeamWithTwoEvents);
	});

	tearDown((){
		_db.close();
	});
}

void deleteTeamWithTwoPlayers() async
{
	final team = Team(
		id: teamId,
		player: player,
		name: "name",
		managerId: "1"
	);

	final player1 = Player(id: "1");
	final teamPlayer1 = TeamPlayer(
		playerId: "1",
		teamId: teamId
	);

	final player2 = Player(id: "2");
	final teamPlayer2 = TeamPlayer(
		playerId: "2",
		teamId: teamId
	);

	await _db.teamDao.insertModel(team);
	await _db.playerDao.insertModel(player1);
	await _db.teamPlayerDao.insertModel(teamPlayer1);
	await _db.playerDao.insertModel(player2);
	await _db.teamPlayerDao.insertModel(teamPlayer2);

	await _db.teamDao.deleteModel(team);

	final teams = await _db.teamDao.getList(player);
	expect(teams.length, equals(0));

	final events = await _db.playerDao.getList(team.id, team.managerId);
	expect(events.length, equals(1));
}

void deleteTeamWithTwoEvents() async
{
	final team = Team(
		id: teamId,
		player: player,
		name: "name"
	);

	final event1 = Event(
		id: "1", 
		teamId: teamId
	);

	final event2 = Event(
		id: "2", 
		teamId: teamId
	);

	await _db.teamDao.insertModel(team);
	await _db.eventDao.insertModel(event1);
	await _db.eventDao.insertModel(event2);

	var events = await _db.eventDao.getList(teamId);

	await _db.teamDao.deleteModel(team);

	final teams = await _db.teamDao.getList(player);
	expect(teams.length, equals(0));

	events = await _db.eventDao.getList(teamId);
	expect(events.length, equals(0));
}