import 'dart:async';

import 'package:floor/floor.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'package:mpm/services/database/models/models.dart';
export 'package:mpm/services/database/models/models.dart';

import 'package:mpm/services/database/daos/daos.dart';
export 'package:mpm/services/database/daos/daos.dart';

part 'database.g.dart';

@Database(entities: [
	Team,
	Player,
	TeamPlayer,
	Event,
	TeamEvent,
	Discrepancy,
	EventDiscrepancy,
	Participation,
	EventParticipation,
	Game,
	TeamGame
], version: 1)
@singleton
abstract class AppDatabase extends FloorDatabase 
{
	TeamDao get teamDao;
	PlayerDao get playerDao;
	TeamPlayerDao get teamPlayerDao;
	EventDao get eventDao;
	TeamEventDao get teamEventDao;
	DiscrepancyDao get discrepancyDao;
	EventDiscrepancyDao get eventDiscrepancyDao;
	ParticipationDao get participationDao;
	EventParticipationDao get eventParticipationDao;
	GameDao get gameDao;
	TeamGameDao get teamGameDao;

	@factoryMethod
	static Future<AppDatabase> create() async 
	{
		return await $FloorAppDatabase.databaseBuilder('database.db').build();
	}

}