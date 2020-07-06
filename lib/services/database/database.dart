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
	Discrepancy,
	Participation,
	Game,
], version: 1)
@singleton
abstract class AppDatabase extends FloorDatabase 
{
	TeamDao get teamDao;
	PlayerDao get playerDao;
	TeamPlayerDao get teamPlayerDao;
	EventDao get eventDao;
	DiscrepancyDao get discrepancyDao;
	ParticipationDao get participationDao;
	GameDao get gameDao;

	@factoryMethod
	static Future<AppDatabase> create() async 
	{
		return await $FloorAppDatabase.databaseBuilder('database.db').build();
	}

}