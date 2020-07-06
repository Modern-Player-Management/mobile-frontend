// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  TeamDao _teamDaoInstance;

  PlayerDao _playerDaoInstance;

  TeamPlayerDao _teamPlayerDaoInstance;

  EventDao _eventDaoInstance;

  TeamEventDao _teamEventDaoInstance;

  DiscrepancyDao _discrepancyDaoInstance;

  EventDiscrepancyDao _eventDiscrepancyDaoInstance;

  ParticipationDao _participationDaoInstance;

  EventParticipationDao _eventParticipationDaoInstance;

  GameDao _gameDaoInstance;

  TeamGameDao _teamGameDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `teams` (`id` TEXT, `player` TEXT, `name` TEXT, `description` TEXT, `image` TEXT, `managerId` TEXT, `created` TEXT, `saved` INTEGER, `create` INTEGER, `deleted` INTEGER, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `players` (`id` TEXT, `username` TEXT, `email` TEXT, `image` TEXT, `created` TEXT, `calendarSecret` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `team_players` (`teamId` TEXT, `playerId` TEXT, `saved` INTEGER, `deleted` INTEGER, FOREIGN KEY (`teamId`) REFERENCES `teams` (`id`) ON UPDATE CASCADE ON DELETE CASCADE, FOREIGN KEY (`playerId`) REFERENCES `players` (`id`) ON UPDATE CASCADE ON DELETE CASCADE, PRIMARY KEY (`teamId`, `playerId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `events` (`id` TEXT, `team` TEXT, `start` TEXT, `end` TEXT, `name` TEXT, `description` TEXT, `type` INTEGER, `currentHasConfirmed` INTEGER, `create` INTEGER, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `team_events` (`teamId` TEXT, `eventId` TEXT, `saved` INTEGER, `deleted` INTEGER, FOREIGN KEY (`teamId`) REFERENCES `teams` (`id`) ON UPDATE CASCADE ON DELETE CASCADE, FOREIGN KEY (`eventId`) REFERENCES `events` (`id`) ON UPDATE CASCADE ON DELETE CASCADE, PRIMARY KEY (`teamId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `discrepancies` (`id` TEXT, `type` INTEGER, `reason` TEXT, `userId` TEXT, `username` TEXT, `delayLength` INTEGER, `create` INTEGER, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `events_discrepancies` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `eventId` TEXT, `discrepancyId` TEXT, `saved` INTEGER, `deleted` INTEGER, FOREIGN KEY (`eventId`) REFERENCES `events` (`id`) ON UPDATE CASCADE ON DELETE CASCADE, FOREIGN KEY (`discrepancyId`) REFERENCES `discrepancies` (`id`) ON UPDATE CASCADE ON DELETE CASCADE)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `participations` (`id` TEXT, `confirmed` INTEGER, `userId` TEXT, `username` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `events_participations` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `eventId` TEXT, `participationId` TEXT, `saved` INTEGER, `deleted` INTEGER, FOREIGN KEY (`eventId`) REFERENCES `events` (`id`) ON UPDATE CASCADE ON DELETE CASCADE, FOREIGN KEY (`participationId`) REFERENCES `participations` (`id`) ON UPDATE CASCADE ON DELETE CASCADE)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `games` (`id` TEXT, `name` TEXT, `date` TEXT, `win` INTEGER, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `team_games` (`teamId` TEXT, `gameId` TEXT, `saved` INTEGER, `deleted` INTEGER, FOREIGN KEY (`teamId`) REFERENCES `teams` (`id`) ON UPDATE CASCADE ON DELETE CASCADE, FOREIGN KEY (`gameId`) REFERENCES `games` (`id`) ON UPDATE CASCADE ON DELETE CASCADE, PRIMARY KEY (`teamId`, `gameId`))');
        await database
            .execute('CREATE INDEX `index_teams_player` ON `teams` (`player`)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  TeamDao get teamDao {
    return _teamDaoInstance ??= _$TeamDao(database, changeListener);
  }

  @override
  PlayerDao get playerDao {
    return _playerDaoInstance ??= _$PlayerDao(database, changeListener);
  }

  @override
  TeamPlayerDao get teamPlayerDao {
    return _teamPlayerDaoInstance ??= _$TeamPlayerDao(database, changeListener);
  }

  @override
  EventDao get eventDao {
    return _eventDaoInstance ??= _$EventDao(database, changeListener);
  }

  @override
  TeamEventDao get teamEventDao {
    return _teamEventDaoInstance ??= _$TeamEventDao(database, changeListener);
  }

  @override
  DiscrepancyDao get discrepancyDao {
    return _discrepancyDaoInstance ??=
        _$DiscrepancyDao(database, changeListener);
  }

  @override
  EventDiscrepancyDao get eventDiscrepancyDao {
    return _eventDiscrepancyDaoInstance ??=
        _$EventDiscrepancyDao(database, changeListener);
  }

  @override
  ParticipationDao get participationDao {
    return _participationDaoInstance ??=
        _$ParticipationDao(database, changeListener);
  }

  @override
  EventParticipationDao get eventParticipationDao {
    return _eventParticipationDaoInstance ??=
        _$EventParticipationDao(database, changeListener);
  }

  @override
  GameDao get gameDao {
    return _gameDaoInstance ??= _$GameDao(database, changeListener);
  }

  @override
  TeamGameDao get teamGameDao {
    return _teamGameDaoInstance ??= _$TeamGameDao(database, changeListener);
  }
}

class _$TeamDao extends TeamDao {
  _$TeamDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _teamInsertionAdapter = InsertionAdapter(
            database,
            'teams',
            (Team item) => <String, dynamic>{
                  'id': item.id,
                  'player': item.player,
                  'name': item.name,
                  'description': item.description,
                  'image': item.image,
                  'managerId': item.managerId,
                  'created': item.created,
                  'saved': item.saved == null ? null : (item.saved ? 1 : 0),
                  'create': item.create == null ? null : (item.create ? 1 : 0),
                  'deleted':
                      item.deleted == null ? null : (item.deleted ? 1 : 0)
                },
            changeListener),
        _teamUpdateAdapter = UpdateAdapter(
            database,
            'teams',
            ['id'],
            (Team item) => <String, dynamic>{
                  'id': item.id,
                  'player': item.player,
                  'name': item.name,
                  'description': item.description,
                  'image': item.image,
                  'managerId': item.managerId,
                  'created': item.created,
                  'saved': item.saved == null ? null : (item.saved ? 1 : 0),
                  'create': item.create == null ? null : (item.create ? 1 : 0),
                  'deleted':
                      item.deleted == null ? null : (item.deleted ? 1 : 0)
                },
            changeListener),
        _teamDeletionAdapter = DeletionAdapter(
            database,
            'teams',
            ['id'],
            (Team item) => <String, dynamic>{
                  'id': item.id,
                  'player': item.player,
                  'name': item.name,
                  'description': item.description,
                  'image': item.image,
                  'managerId': item.managerId,
                  'created': item.created,
                  'saved': item.saved == null ? null : (item.saved ? 1 : 0),
                  'create': item.create == null ? null : (item.create ? 1 : 0),
                  'deleted':
                      item.deleted == null ? null : (item.deleted ? 1 : 0)
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _teamsMapper = (Map<String, dynamic> row) => Team(
      id: row['id'] as String,
      name: row['name'] as String,
      description: row['description'] as String,
      image: row['image'] as String,
      player: row['player'] as String,
      managerId: row['managerId'] as String,
      saved: row['saved'] == null ? null : (row['saved'] as int) != 0,
      create: row['create'] == null ? null : (row['create'] as int) != 0,
      deleted: row['deleted'] == null ? null : (row['deleted'] as int) != 0);

  final InsertionAdapter<Team> _teamInsertionAdapter;

  final UpdateAdapter<Team> _teamUpdateAdapter;

  final DeletionAdapter<Team> _teamDeletionAdapter;

  @override
  Stream<List<Team>> getStream(String player) {
    return _queryAdapter.queryListStream(
        'select * from teams where player = ? and deleted = 0 order by name',
        arguments: <dynamic>[player],
        queryableName: 'teams',
        isView: false,
        mapper: _teamsMapper);
  }

  @override
  Future<List<Team>> getList(String player) async {
    return _queryAdapter.queryList(
        'select * from teams where player = ? and deleted = 0 order by name',
        arguments: <dynamic>[player],
        mapper: _teamsMapper);
  }

  @override
  Future<List<Team>> getSaved(String player) async {
    return _queryAdapter.queryList(
        'select * from teams where player = ? and saved = 1 and deleted = 0',
        arguments: <dynamic>[player],
        mapper: _teamsMapper);
  }

  @override
  Future<List<Team>> getUnsaved(String player) async {
    return _queryAdapter.queryList(
        'select * from teams where player = ? and saved = 0 and deleted = 0',
        arguments: <dynamic>[player],
        mapper: _teamsMapper);
  }

  @override
  Future<List<Team>> getUndeleted(String player) async {
    return _queryAdapter.queryList(
        'select * from teams where player = ? and deleted = 1',
        arguments: <dynamic>[player],
        mapper: _teamsMapper);
  }

  @override
  Future<void> updateId(String oldId, String newId) async {
    await _queryAdapter.queryNoReturn('update teams set id = ? where id = ?',
        arguments: <dynamic>[oldId, newId]);
  }

  @override
  Future<int> insertModel(Team model) {
    return _teamInsertionAdapter.insertAndReturnId(
        model, OnConflictStrategy.replace);
  }

  @override
  Future<int> updateModel(Team model) {
    return _teamUpdateAdapter.updateAndReturnChangedRows(
        model, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteModel(Team model) {
    return _teamDeletionAdapter.deleteAndReturnChangedRows(model);
  }
}

class _$PlayerDao extends PlayerDao {
  _$PlayerDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _playerInsertionAdapter = InsertionAdapter(
            database,
            'players',
            (Player item) => <String, dynamic>{
                  'id': item.id,
                  'username': item.username,
                  'email': item.email,
                  'image': item.image,
                  'created': item.created,
                  'calendarSecret': item.calendarSecret
                },
            changeListener),
        _playerUpdateAdapter = UpdateAdapter(
            database,
            'players',
            ['id'],
            (Player item) => <String, dynamic>{
                  'id': item.id,
                  'username': item.username,
                  'email': item.email,
                  'image': item.image,
                  'created': item.created,
                  'calendarSecret': item.calendarSecret
                },
            changeListener),
        _playerDeletionAdapter = DeletionAdapter(
            database,
            'players',
            ['id'],
            (Player item) => <String, dynamic>{
                  'id': item.id,
                  'username': item.username,
                  'email': item.email,
                  'image': item.image,
                  'created': item.created,
                  'calendarSecret': item.calendarSecret
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _playersMapper = (Map<String, dynamic> row) => Player(
      id: row['id'] as String,
      username: row['username'] as String,
      email: row['email'] as String,
      image: row['image'] as String,
      created: row['created'] as String,
      calendarSecret: row['calendarSecret'] as String);

  final InsertionAdapter<Player> _playerInsertionAdapter;

  final UpdateAdapter<Player> _playerUpdateAdapter;

  final DeletionAdapter<Player> _playerDeletionAdapter;

  @override
  Future<Player> get(String id) async {
    return _queryAdapter.query('select * from players where id = ?',
        arguments: <dynamic>[id], mapper: _playersMapper);
  }

  @override
  Future<void> updateId(String oldId, String newId) async {
    await _queryAdapter.queryNoReturn('update players set id = ? where id = ?',
        arguments: <dynamic>[oldId, newId]);
  }

  @override
  Stream<List<Player>> getStream(String teamId, String managerId) {
    return _queryAdapter.queryListStream(
        'select * from players left join team_players on players.id = team_players.playerId and team_players.teamId = ? and team_players.playerId != ? and team_players.deleted = 0',
        arguments: <dynamic>[teamId, managerId],
        queryableName: 'players',
        isView: false,
        mapper: _playersMapper);
  }

  @override
  Future<List<Player>> getList(String teamId, String managerId) async {
    return _queryAdapter.queryList(
        'select * from players left join team_players on players.id = team_players.playerId and team_players.teamId = ? and team_players.playerId != ? and team_players.deleted = 0',
        arguments: <dynamic>[teamId, managerId],
        mapper: _playersMapper);
  }

  @override
  Future<int> insertModel(Player model) {
    return _playerInsertionAdapter.insertAndReturnId(
        model, OnConflictStrategy.replace);
  }

  @override
  Future<int> updateModel(Player model) {
    return _playerUpdateAdapter.updateAndReturnChangedRows(
        model, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteModel(Player model) {
    return _playerDeletionAdapter.deleteAndReturnChangedRows(model);
  }
}

class _$TeamPlayerDao extends TeamPlayerDao {
  _$TeamPlayerDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _teamPlayerInsertionAdapter = InsertionAdapter(
            database,
            'team_players',
            (TeamPlayer item) => <String, dynamic>{
                  'teamId': item.teamId,
                  'playerId': item.playerId,
                  'saved': item.saved == null ? null : (item.saved ? 1 : 0),
                  'deleted':
                      item.deleted == null ? null : (item.deleted ? 1 : 0)
                },
            changeListener),
        _teamPlayerUpdateAdapter = UpdateAdapter(
            database,
            'team_players',
            ['teamId', 'playerId'],
            (TeamPlayer item) => <String, dynamic>{
                  'teamId': item.teamId,
                  'playerId': item.playerId,
                  'saved': item.saved == null ? null : (item.saved ? 1 : 0),
                  'deleted':
                      item.deleted == null ? null : (item.deleted ? 1 : 0)
                },
            changeListener),
        _teamPlayerDeletionAdapter = DeletionAdapter(
            database,
            'team_players',
            ['teamId', 'playerId'],
            (TeamPlayer item) => <String, dynamic>{
                  'teamId': item.teamId,
                  'playerId': item.playerId,
                  'saved': item.saved == null ? null : (item.saved ? 1 : 0),
                  'deleted':
                      item.deleted == null ? null : (item.deleted ? 1 : 0)
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _team_playersMapper = (Map<String, dynamic> row) => TeamPlayer(
      teamId: row['teamId'] as String,
      playerId: row['playerId'] as String,
      saved: row['saved'] == null ? null : (row['saved'] as int) != 0,
      deleted: row['deleted'] == null ? null : (row['deleted'] as int) != 0);

  final InsertionAdapter<TeamPlayer> _teamPlayerInsertionAdapter;

  final UpdateAdapter<TeamPlayer> _teamPlayerUpdateAdapter;

  final DeletionAdapter<TeamPlayer> _teamPlayerDeletionAdapter;

  @override
  Stream<List<TeamPlayer>> getStream(String teamId) {
    return _queryAdapter.queryListStream(
        'select * from team_players where teamId = ? and deleted = 0',
        arguments: <dynamic>[teamId],
        queryableName: 'team_players',
        isView: false,
        mapper: _team_playersMapper);
  }

  @override
  Future<List<TeamPlayer>> getList(String teamId) async {
    return _queryAdapter.queryList(
        'select * from team_players where teamId = ? and deleted = 0',
        arguments: <dynamic>[teamId],
        mapper: _team_playersMapper);
  }

  @override
  Future<List<TeamPlayer>> getSaved(String teamId) async {
    return _queryAdapter.queryList(
        'select * from team_players where teamId = ? and saved = 1 and deleted = 0',
        arguments: <dynamic>[teamId],
        mapper: _team_playersMapper);
  }

  @override
  Future<List<TeamPlayer>> getUnsaved(String teamId) async {
    return _queryAdapter.queryList(
        'select * from team_players where teamId = ? and saved = 0 and deleted = 0',
        arguments: <dynamic>[teamId],
        mapper: _team_playersMapper);
  }

  @override
  Future<List<TeamPlayer>> getUndeleted(String teamId) async {
    return _queryAdapter.queryList(
        'select * from team_players where teamId = ? and deleted = 1',
        arguments: <dynamic>[teamId],
        mapper: _team_playersMapper);
  }

  @override
  Future<int> insertModel(TeamPlayer model) {
    return _teamPlayerInsertionAdapter.insertAndReturnId(
        model, OnConflictStrategy.replace);
  }

  @override
  Future<int> updateModel(TeamPlayer model) {
    return _teamPlayerUpdateAdapter.updateAndReturnChangedRows(
        model, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteModel(TeamPlayer model) {
    return _teamPlayerDeletionAdapter.deleteAndReturnChangedRows(model);
  }
}

class _$EventDao extends EventDao {
  _$EventDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _eventInsertionAdapter = InsertionAdapter(
            database,
            'events',
            (Event item) => <String, dynamic>{
                  'id': item.id,
                  'team': item.team,
                  'start': item.start,
                  'end': item.end,
                  'name': item.name,
                  'description': item.description,
                  'type': item.type,
                  'currentHasConfirmed': item.currentHasConfirmed == null
                      ? null
                      : (item.currentHasConfirmed ? 1 : 0),
                  'create': item.create == null ? null : (item.create ? 1 : 0)
                },
            changeListener),
        _eventUpdateAdapter = UpdateAdapter(
            database,
            'events',
            ['id'],
            (Event item) => <String, dynamic>{
                  'id': item.id,
                  'team': item.team,
                  'start': item.start,
                  'end': item.end,
                  'name': item.name,
                  'description': item.description,
                  'type': item.type,
                  'currentHasConfirmed': item.currentHasConfirmed == null
                      ? null
                      : (item.currentHasConfirmed ? 1 : 0),
                  'create': item.create == null ? null : (item.create ? 1 : 0)
                },
            changeListener),
        _eventDeletionAdapter = DeletionAdapter(
            database,
            'events',
            ['id'],
            (Event item) => <String, dynamic>{
                  'id': item.id,
                  'team': item.team,
                  'start': item.start,
                  'end': item.end,
                  'name': item.name,
                  'description': item.description,
                  'type': item.type,
                  'currentHasConfirmed': item.currentHasConfirmed == null
                      ? null
                      : (item.currentHasConfirmed ? 1 : 0),
                  'create': item.create == null ? null : (item.create ? 1 : 0)
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _eventsMapper = (Map<String, dynamic> row) => Event(
      id: row['id'] as String,
      team: row['team'] as String,
      start: row['start'] as String,
      end: row['end'] as String,
      name: row['name'] as String,
      description: row['description'] as String,
      type: row['type'] as int,
      currentHasConfirmed: row['currentHasConfirmed'] == null
          ? null
          : (row['currentHasConfirmed'] as int) != 0,
      create: row['create'] == null ? null : (row['create'] as int) != 0);

  final InsertionAdapter<Event> _eventInsertionAdapter;

  final UpdateAdapter<Event> _eventUpdateAdapter;

  final DeletionAdapter<Event> _eventDeletionAdapter;

  @override
  Future<Event> get(String id) async {
    return _queryAdapter.query('select * from events where id = ?',
        arguments: <dynamic>[id], mapper: _eventsMapper);
  }

  @override
  Future<void> updateId(String oldId, String newId) async {
    await _queryAdapter.queryNoReturn('update events set id = ? where id = ?',
        arguments: <dynamic>[oldId, newId]);
  }

  @override
  Stream<List<Event>> getStream(String teamId) {
    return _queryAdapter.queryListStream(
        'select * from events left join team_events on events.id = team_events.eventId and team_events.teamId = ? and team_events.deleted = 0',
        arguments: <dynamic>[teamId],
        queryableName: 'events',
        isView: false,
        mapper: _eventsMapper);
  }

  @override
  Future<List<Event>> getList(String teamId) async {
    return _queryAdapter.queryList(
        'select * from events left join team_events on events.id = team_events.eventId and team_events.teamId = ? and team_events.deleted = 0',
        arguments: <dynamic>[teamId],
        mapper: _eventsMapper);
  }

  @override
  Future<List<Event>> getSaved(String teamId) async {
    return _queryAdapter.queryList(
        'select * from events left join team_events on events.id = team_events.eventId and team_events.teamId = ? and team_events.saved = 1 and team_events.deleted = 0',
        arguments: <dynamic>[teamId],
        mapper: _eventsMapper);
  }

  @override
  Future<List<Event>> getUnsaved(String teamId) async {
    return _queryAdapter.queryList(
        'select * from events left join team_events on events.id = team_events.eventId and team_events.teamId = ? and team_events.saved = 0 and team_events.deleted = 0',
        arguments: <dynamic>[teamId],
        mapper: _eventsMapper);
  }

  @override
  Future<List<Event>> getUndeleted(String teamId) async {
    return _queryAdapter.queryList(
        'select * from events left join team_events on events.id = team_events.eventId and team_events.teamId = ? and team_events.deleted = 1',
        arguments: <dynamic>[teamId],
        mapper: _eventsMapper);
  }

  @override
  Future<int> insertModel(Event model) {
    return _eventInsertionAdapter.insertAndReturnId(
        model, OnConflictStrategy.replace);
  }

  @override
  Future<int> updateModel(Event model) {
    return _eventUpdateAdapter.updateAndReturnChangedRows(
        model, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteModel(Event model) {
    return _eventDeletionAdapter.deleteAndReturnChangedRows(model);
  }
}

class _$TeamEventDao extends TeamEventDao {
  _$TeamEventDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _teamEventInsertionAdapter = InsertionAdapter(
            database,
            'team_events',
            (TeamEvent item) => <String, dynamic>{
                  'teamId': item.teamId,
                  'eventId': item.eventId,
                  'saved': item.saved == null ? null : (item.saved ? 1 : 0),
                  'deleted':
                      item.deleted == null ? null : (item.deleted ? 1 : 0)
                },
            changeListener),
        _teamEventUpdateAdapter = UpdateAdapter(
            database,
            'team_events',
            ['teamId'],
            (TeamEvent item) => <String, dynamic>{
                  'teamId': item.teamId,
                  'eventId': item.eventId,
                  'saved': item.saved == null ? null : (item.saved ? 1 : 0),
                  'deleted':
                      item.deleted == null ? null : (item.deleted ? 1 : 0)
                },
            changeListener),
        _teamEventDeletionAdapter = DeletionAdapter(
            database,
            'team_events',
            ['teamId'],
            (TeamEvent item) => <String, dynamic>{
                  'teamId': item.teamId,
                  'eventId': item.eventId,
                  'saved': item.saved == null ? null : (item.saved ? 1 : 0),
                  'deleted':
                      item.deleted == null ? null : (item.deleted ? 1 : 0)
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _team_eventsMapper = (Map<String, dynamic> row) => TeamEvent(
      teamId: row['teamId'] as String,
      eventId: row['eventId'] as String,
      saved: row['saved'] == null ? null : (row['saved'] as int) != 0,
      deleted: row['deleted'] == null ? null : (row['deleted'] as int) != 0);

  final InsertionAdapter<TeamEvent> _teamEventInsertionAdapter;

  final UpdateAdapter<TeamEvent> _teamEventUpdateAdapter;

  final DeletionAdapter<TeamEvent> _teamEventDeletionAdapter;

  @override
  Stream<List<TeamEvent>> getStream(String teamId) {
    return _queryAdapter.queryListStream(
        'select * from team_events where teamId = ? and deleted = 0',
        arguments: <dynamic>[teamId],
        queryableName: 'team_events',
        isView: false,
        mapper: _team_eventsMapper);
  }

  @override
  Future<List<TeamEvent>> getList(String teamId) async {
    return _queryAdapter.queryList(
        'select * from team_events where teamId = ? and deleted = 0',
        arguments: <dynamic>[teamId],
        mapper: _team_eventsMapper);
  }

  @override
  Future<List<TeamEvent>> getSaved(String teamId) async {
    return _queryAdapter.queryList(
        'select * from team_events where teamId = ? and saved = 1 and deleted = 0',
        arguments: <dynamic>[teamId],
        mapper: _team_eventsMapper);
  }

  @override
  Future<List<TeamEvent>> getUnsaved(String teamId) async {
    return _queryAdapter.queryList(
        'select * from team_events where teamId = ? and saved = 0 and deleted = 0',
        arguments: <dynamic>[teamId],
        mapper: _team_eventsMapper);
  }

  @override
  Future<List<TeamEvent>> getUndeleted(String teamId) async {
    return _queryAdapter.queryList(
        'select * from team_events where teamId = ? and deleted = 1',
        arguments: <dynamic>[teamId],
        mapper: _team_eventsMapper);
  }

  @override
  Future<int> insertModel(TeamEvent model) {
    return _teamEventInsertionAdapter.insertAndReturnId(
        model, OnConflictStrategy.replace);
  }

  @override
  Future<int> updateModel(TeamEvent model) {
    return _teamEventUpdateAdapter.updateAndReturnChangedRows(
        model, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteModel(TeamEvent model) {
    return _teamEventDeletionAdapter.deleteAndReturnChangedRows(model);
  }
}

class _$DiscrepancyDao extends DiscrepancyDao {
  _$DiscrepancyDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _discrepancyInsertionAdapter = InsertionAdapter(
            database,
            'discrepancies',
            (Discrepancy item) => <String, dynamic>{
                  'id': item.id,
                  'type': item.type,
                  'reason': item.reason,
                  'userId': item.userId,
                  'username': item.username,
                  'delayLength': item.delayLength,
                  'create': item.create == null ? null : (item.create ? 1 : 0)
                },
            changeListener),
        _discrepancyUpdateAdapter = UpdateAdapter(
            database,
            'discrepancies',
            ['id'],
            (Discrepancy item) => <String, dynamic>{
                  'id': item.id,
                  'type': item.type,
                  'reason': item.reason,
                  'userId': item.userId,
                  'username': item.username,
                  'delayLength': item.delayLength,
                  'create': item.create == null ? null : (item.create ? 1 : 0)
                },
            changeListener),
        _discrepancyDeletionAdapter = DeletionAdapter(
            database,
            'discrepancies',
            ['id'],
            (Discrepancy item) => <String, dynamic>{
                  'id': item.id,
                  'type': item.type,
                  'reason': item.reason,
                  'userId': item.userId,
                  'username': item.username,
                  'delayLength': item.delayLength,
                  'create': item.create == null ? null : (item.create ? 1 : 0)
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _discrepanciesMapper = (Map<String, dynamic> row) => Discrepancy(
      id: row['id'] as String,
      type: row['type'] as int,
      reason: row['reason'] as String,
      delayLength: row['delayLength'] as int,
      create: row['create'] == null ? null : (row['create'] as int) != 0);

  final InsertionAdapter<Discrepancy> _discrepancyInsertionAdapter;

  final UpdateAdapter<Discrepancy> _discrepancyUpdateAdapter;

  final DeletionAdapter<Discrepancy> _discrepancyDeletionAdapter;

  @override
  Future<Discrepancy> get(String id) async {
    return _queryAdapter.query('select * from discrepancies where id = ?',
        arguments: <dynamic>[id], mapper: _discrepanciesMapper);
  }

  @override
  Future<void> updateId(String oldId, String newId) async {
    await _queryAdapter.queryNoReturn(
        'update discrepancies set id = ? where id = ?',
        arguments: <dynamic>[oldId, newId]);
  }

  @override
  Stream<List<Discrepancy>> getStream(String eventId) {
    return _queryAdapter.queryListStream(
        'select * from discrepancies left join event_discrepancies on discrepancies.id = event_discrepancies.discrepancyId and event_discrepancies.eventId = ? and event_discrepancies.deleted = 0',
        arguments: <dynamic>[eventId],
        queryableName: 'discrepancies',
        isView: false,
        mapper: _discrepanciesMapper);
  }

  @override
  Future<List<Discrepancy>> getList(String eventId) async {
    return _queryAdapter.queryList(
        'select * from discrepancies left join event_discrepancies on discrepancies.id = event_discrepancies.discrepancyId and event_discrepancies.eventId = ? and event_discrepancies.deleted = 0',
        arguments: <dynamic>[eventId],
        mapper: _discrepanciesMapper);
  }

  @override
  Future<List<Discrepancy>> getSaved(String eventId) async {
    return _queryAdapter.queryList(
        'select * from discrepancies left join event_discrepancies on discrepancies.id = event_discrepancies.discrepancyId and event_discrepancies.eventId = ? and event_discrepancies.saved = 1 event_discrepancies.deleted = 0',
        arguments: <dynamic>[eventId],
        mapper: _discrepanciesMapper);
  }

  @override
  Future<List<Discrepancy>> getUnsaved(String eventId) async {
    return _queryAdapter.queryList(
        'select * from discrepancies left join event_discrepancies on discrepancies.id = event_discrepancies.discrepancyId and event_discrepancies.eventId = ? and event_discrepancies.saved = 0 event_discrepancies.deleted = 0',
        arguments: <dynamic>[eventId],
        mapper: _discrepanciesMapper);
  }

  @override
  Future<List<Discrepancy>> getUndeleted(String eventId) async {
    return _queryAdapter.queryList(
        'select * from discrepancies left join event_discrepancies on discrepancies.id = event_discrepancies.discrepancyId and event_discrepancies.eventId = ? and event_discrepancies.deleted = 1',
        arguments: <dynamic>[eventId],
        mapper: _discrepanciesMapper);
  }

  @override
  Future<int> insertModel(Discrepancy model) {
    return _discrepancyInsertionAdapter.insertAndReturnId(
        model, OnConflictStrategy.replace);
  }

  @override
  Future<int> updateModel(Discrepancy model) {
    return _discrepancyUpdateAdapter.updateAndReturnChangedRows(
        model, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteModel(Discrepancy model) {
    return _discrepancyDeletionAdapter.deleteAndReturnChangedRows(model);
  }
}

class _$EventDiscrepancyDao extends EventDiscrepancyDao {
  _$EventDiscrepancyDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _eventDiscrepancyInsertionAdapter = InsertionAdapter(
            database,
            'events_discrepancies',
            (EventDiscrepancy item) => <String, dynamic>{
                  'id': item.id,
                  'eventId': item.eventId,
                  'discrepancyId': item.discrepancyId,
                  'saved': item.saved == null ? null : (item.saved ? 1 : 0),
                  'deleted':
                      item.deleted == null ? null : (item.deleted ? 1 : 0)
                },
            changeListener),
        _eventDiscrepancyUpdateAdapter = UpdateAdapter(
            database,
            'events_discrepancies',
            ['id'],
            (EventDiscrepancy item) => <String, dynamic>{
                  'id': item.id,
                  'eventId': item.eventId,
                  'discrepancyId': item.discrepancyId,
                  'saved': item.saved == null ? null : (item.saved ? 1 : 0),
                  'deleted':
                      item.deleted == null ? null : (item.deleted ? 1 : 0)
                },
            changeListener),
        _eventDiscrepancyDeletionAdapter = DeletionAdapter(
            database,
            'events_discrepancies',
            ['id'],
            (EventDiscrepancy item) => <String, dynamic>{
                  'id': item.id,
                  'eventId': item.eventId,
                  'discrepancyId': item.discrepancyId,
                  'saved': item.saved == null ? null : (item.saved ? 1 : 0),
                  'deleted':
                      item.deleted == null ? null : (item.deleted ? 1 : 0)
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _events_discrepanciesMapper = (Map<String, dynamic> row) =>
      EventDiscrepancy(
          id: row['id'] as int,
          eventId: row['eventId'] as String,
          discrepancyId: row['discrepancyId'] as String,
          saved: row['saved'] == null ? null : (row['saved'] as int) != 0,
          deleted:
              row['deleted'] == null ? null : (row['deleted'] as int) != 0);

  final InsertionAdapter<EventDiscrepancy> _eventDiscrepancyInsertionAdapter;

  final UpdateAdapter<EventDiscrepancy> _eventDiscrepancyUpdateAdapter;

  final DeletionAdapter<EventDiscrepancy> _eventDiscrepancyDeletionAdapter;

  @override
  Stream<List<EventDiscrepancy>> getStream(String eventId) {
    return _queryAdapter.queryListStream(
        'select * from events_discrepancies where eventId = ? and deleted = 0',
        arguments: <dynamic>[eventId],
        queryableName: 'events_discrepancies',
        isView: false,
        mapper: _events_discrepanciesMapper);
  }

  @override
  Future<List<EventDiscrepancy>> getList(String eventId) async {
    return _queryAdapter.queryList(
        'select * from events_discrepancies where eventId = ? and deleted = 0',
        arguments: <dynamic>[eventId],
        mapper: _events_discrepanciesMapper);
  }

  @override
  Future<List<EventDiscrepancy>> getSaved(String eventId) async {
    return _queryAdapter.queryList(
        'select * from events_discrepancies where eventId = ? and saved = 1 and deleted = 0',
        arguments: <dynamic>[eventId],
        mapper: _events_discrepanciesMapper);
  }

  @override
  Future<List<EventDiscrepancy>> getUnsaved(String eventId) async {
    return _queryAdapter.queryList(
        'select * from events_discrepancies where eventId = ? and saved = 0 and deleted = 0',
        arguments: <dynamic>[eventId],
        mapper: _events_discrepanciesMapper);
  }

  @override
  Future<List<EventDiscrepancy>> getUndeleted(String eventId) async {
    return _queryAdapter.queryList(
        'select * from events_discrepancies where eventId = ? and deleted = 1',
        arguments: <dynamic>[eventId],
        mapper: _events_discrepanciesMapper);
  }

  @override
  Future<int> insertModel(EventDiscrepancy model) {
    return _eventDiscrepancyInsertionAdapter.insertAndReturnId(
        model, OnConflictStrategy.replace);
  }

  @override
  Future<int> updateModel(EventDiscrepancy model) {
    return _eventDiscrepancyUpdateAdapter.updateAndReturnChangedRows(
        model, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteModel(EventDiscrepancy model) {
    return _eventDiscrepancyDeletionAdapter.deleteAndReturnChangedRows(model);
  }
}

class _$ParticipationDao extends ParticipationDao {
  _$ParticipationDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _participationInsertionAdapter = InsertionAdapter(
            database,
            'participations',
            (Participation item) => <String, dynamic>{
                  'id': item.id,
                  'confirmed':
                      item.confirmed == null ? null : (item.confirmed ? 1 : 0),
                  'userId': item.userId,
                  'username': item.username
                },
            changeListener),
        _participationUpdateAdapter = UpdateAdapter(
            database,
            'participations',
            ['id'],
            (Participation item) => <String, dynamic>{
                  'id': item.id,
                  'confirmed':
                      item.confirmed == null ? null : (item.confirmed ? 1 : 0),
                  'userId': item.userId,
                  'username': item.username
                },
            changeListener),
        _participationDeletionAdapter = DeletionAdapter(
            database,
            'participations',
            ['id'],
            (Participation item) => <String, dynamic>{
                  'id': item.id,
                  'confirmed':
                      item.confirmed == null ? null : (item.confirmed ? 1 : 0),
                  'userId': item.userId,
                  'username': item.username
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _participationsMapper = (Map<String, dynamic> row) =>
      Participation(
          id: row['id'] as String,
          confirmed:
              row['confirmed'] == null ? null : (row['confirmed'] as int) != 0,
          userId: row['userId'] as String,
          username: row['username'] as String);

  final InsertionAdapter<Participation> _participationInsertionAdapter;

  final UpdateAdapter<Participation> _participationUpdateAdapter;

  final DeletionAdapter<Participation> _participationDeletionAdapter;

  @override
  Future<Participation> get(String id) async {
    return _queryAdapter.query('select * from participations where id = ?',
        arguments: <dynamic>[id], mapper: _participationsMapper);
  }

  @override
  Future<void> updateId(String oldId, String newId) async {
    await _queryAdapter.queryNoReturn(
        'update participations set id = ? where id = ?',
        arguments: <dynamic>[oldId, newId]);
  }

  @override
  Stream<List<Participation>> getStream(String eventId) {
    return _queryAdapter.queryListStream(
        'select * from participations left join event_participations on participations.id = event_participations.participationId and event_participations.eventId = ? and event_participations.deleted = 0',
        arguments: <dynamic>[eventId],
        queryableName: 'participations',
        isView: false,
        mapper: _participationsMapper);
  }

  @override
  Future<List<Participation>> getList(String eventId) async {
    return _queryAdapter.queryList(
        'select * from participations left join event_participations on participations.id = event_participations.participationId and event_participations.eventId = ? and event_participations.deleted = 0',
        arguments: <dynamic>[eventId],
        mapper: _participationsMapper);
  }

  @override
  Future<List<Participation>> getSaved(String eventId) async {
    return _queryAdapter.queryList(
        'select * from participations left join event_participations on participations.id = event_participations.participationId and event_participations.eventId = ? and event_participations.saved = 1 and event_participations.deleted = 0',
        arguments: <dynamic>[eventId],
        mapper: _participationsMapper);
  }

  @override
  Future<List<Participation>> getUnsaved(String eventId) async {
    return _queryAdapter.queryList(
        'select * from participations left join event_participations on participations.id = event_participations.participationId and event_participations.eventId = ? and event_participations.saved = 0 and event_participations.deleted = 0',
        arguments: <dynamic>[eventId],
        mapper: _participationsMapper);
  }

  @override
  Future<List<Participation>> getUndeleted(String eventId) async {
    return _queryAdapter.queryList(
        'select * from participations left join event_participations on participations.id = event_participations.participationId and event_participations.eventId = ? and event_participations.deleted = 0',
        arguments: <dynamic>[eventId],
        mapper: _participationsMapper);
  }

  @override
  Future<int> insertModel(Participation model) {
    return _participationInsertionAdapter.insertAndReturnId(
        model, OnConflictStrategy.replace);
  }

  @override
  Future<int> updateModel(Participation model) {
    return _participationUpdateAdapter.updateAndReturnChangedRows(
        model, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteModel(Participation model) {
    return _participationDeletionAdapter.deleteAndReturnChangedRows(model);
  }
}

class _$EventParticipationDao extends EventParticipationDao {
  _$EventParticipationDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _eventParticipationInsertionAdapter = InsertionAdapter(
            database,
            'events_participations',
            (EventParticipation item) => <String, dynamic>{
                  'id': item.id,
                  'eventId': item.eventId,
                  'participationId': item.participationId,
                  'saved': item.saved == null ? null : (item.saved ? 1 : 0),
                  'deleted':
                      item.deleted == null ? null : (item.deleted ? 1 : 0)
                },
            changeListener),
        _eventParticipationUpdateAdapter = UpdateAdapter(
            database,
            'events_participations',
            ['id'],
            (EventParticipation item) => <String, dynamic>{
                  'id': item.id,
                  'eventId': item.eventId,
                  'participationId': item.participationId,
                  'saved': item.saved == null ? null : (item.saved ? 1 : 0),
                  'deleted':
                      item.deleted == null ? null : (item.deleted ? 1 : 0)
                },
            changeListener),
        _eventParticipationDeletionAdapter = DeletionAdapter(
            database,
            'events_participations',
            ['id'],
            (EventParticipation item) => <String, dynamic>{
                  'id': item.id,
                  'eventId': item.eventId,
                  'participationId': item.participationId,
                  'saved': item.saved == null ? null : (item.saved ? 1 : 0),
                  'deleted':
                      item.deleted == null ? null : (item.deleted ? 1 : 0)
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _events_participationsMapper = (Map<String, dynamic> row) =>
      EventParticipation(
          id: row['id'] as int,
          eventId: row['eventId'] as String,
          participationId: row['participationId'] as String,
          saved: row['saved'] == null ? null : (row['saved'] as int) != 0,
          deleted:
              row['deleted'] == null ? null : (row['deleted'] as int) != 0);

  final InsertionAdapter<EventParticipation>
      _eventParticipationInsertionAdapter;

  final UpdateAdapter<EventParticipation> _eventParticipationUpdateAdapter;

  final DeletionAdapter<EventParticipation> _eventParticipationDeletionAdapter;

  @override
  Stream<List<EventParticipation>> getStream(String eventId) {
    return _queryAdapter.queryListStream(
        'select * from events_participations where eventId = ? and deleted = 0',
        arguments: <dynamic>[eventId],
        queryableName: 'events_participations',
        isView: false,
        mapper: _events_participationsMapper);
  }

  @override
  Future<List<EventParticipation>> getList(String eventId) async {
    return _queryAdapter.queryList(
        'select * from events_participations where eventId = ? and deleted = 0',
        arguments: <dynamic>[eventId],
        mapper: _events_participationsMapper);
  }

  @override
  Future<List<EventParticipation>> getSaved(String eventId) async {
    return _queryAdapter.queryList(
        'select * from events_participations where eventId = ? and saved = 1 and deleted = 0',
        arguments: <dynamic>[eventId],
        mapper: _events_participationsMapper);
  }

  @override
  Future<List<EventParticipation>> getUnsaved(String eventId) async {
    return _queryAdapter.queryList(
        'select * from events_participations where eventId = ? and saved = 0 and deleted = 0',
        arguments: <dynamic>[eventId],
        mapper: _events_participationsMapper);
  }

  @override
  Future<List<EventParticipation>> getUndeleted(String eventId) async {
    return _queryAdapter.queryList(
        'select * from events_participations where eventId = ? and deleted = 1',
        arguments: <dynamic>[eventId],
        mapper: _events_participationsMapper);
  }

  @override
  Future<int> insertModel(EventParticipation model) {
    return _eventParticipationInsertionAdapter.insertAndReturnId(
        model, OnConflictStrategy.replace);
  }

  @override
  Future<int> updateModel(EventParticipation model) {
    return _eventParticipationUpdateAdapter.updateAndReturnChangedRows(
        model, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteModel(EventParticipation model) {
    return _eventParticipationDeletionAdapter.deleteAndReturnChangedRows(model);
  }
}

class _$GameDao extends GameDao {
  _$GameDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _gameInsertionAdapter = InsertionAdapter(
            database,
            'games',
            (Game item) => <String, dynamic>{
                  'id': item.id,
                  'name': item.name,
                  'date': item.date,
                  'win': item.win
                },
            changeListener),
        _gameUpdateAdapter = UpdateAdapter(
            database,
            'games',
            ['id'],
            (Game item) => <String, dynamic>{
                  'id': item.id,
                  'name': item.name,
                  'date': item.date,
                  'win': item.win
                },
            changeListener),
        _gameDeletionAdapter = DeletionAdapter(
            database,
            'games',
            ['id'],
            (Game item) => <String, dynamic>{
                  'id': item.id,
                  'name': item.name,
                  'date': item.date,
                  'win': item.win
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _gamesMapper = (Map<String, dynamic> row) => Game(
      id: row['id'] as String,
      name: row['name'] as String,
      date: row['date'] as String,
      win: row['win'] as int);

  final InsertionAdapter<Game> _gameInsertionAdapter;

  final UpdateAdapter<Game> _gameUpdateAdapter;

  final DeletionAdapter<Game> _gameDeletionAdapter;

  @override
  Future<Game> get(String id) async {
    return _queryAdapter.query('select * from games where id = ?',
        arguments: <dynamic>[id], mapper: _gamesMapper);
  }

  @override
  Future<void> updateId(String oldId, String newId) async {
    await _queryAdapter.queryNoReturn('update games set id = ? where id = ?',
        arguments: <dynamic>[oldId, newId]);
  }

  @override
  Stream<List<Game>> getStream(String teamId) {
    return _queryAdapter.queryListStream(
        'select * from games left join team_games on games.id = team_games.gameId and team_games.teamId = ? and team_games.deleted = 0',
        arguments: <dynamic>[teamId],
        queryableName: 'games',
        isView: false,
        mapper: _gamesMapper);
  }

  @override
  Future<List<Game>> getList(String teamId) async {
    return _queryAdapter.queryList(
        'select * from games left join team_games on games.id = team_games.gameId and team_games.teamId = ? and team_games.deleted = 0',
        arguments: <dynamic>[teamId],
        mapper: _gamesMapper);
  }

  @override
  Future<List<Game>> getSaved(String teamId) async {
    return _queryAdapter.queryList(
        'select * from games left join team_games on games.id = team_games.gameId and team_games.teamId = ? and team_games.saved = 1 and team_games.deleted = 0',
        arguments: <dynamic>[teamId],
        mapper: _gamesMapper);
  }

  @override
  Future<List<Game>> getUnsaved(String teamId) async {
    return _queryAdapter.queryList(
        'select * from games left join team_games on games.id = team_games.gameId and team_games.teamId = ? and team_games.saved = 0 and team_games.deleted = 0',
        arguments: <dynamic>[teamId],
        mapper: _gamesMapper);
  }

  @override
  Future<List<Game>> getUndeleted(String teamId) async {
    return _queryAdapter.queryList(
        'select * from games left join team_games on games.id = team_games.gameId and team_games.teamId = ? and team_games.deleted = 1',
        arguments: <dynamic>[teamId],
        mapper: _gamesMapper);
  }

  @override
  Future<int> insertModel(Game model) {
    return _gameInsertionAdapter.insertAndReturnId(
        model, OnConflictStrategy.replace);
  }

  @override
  Future<int> updateModel(Game model) {
    return _gameUpdateAdapter.updateAndReturnChangedRows(
        model, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteModel(Game model) {
    return _gameDeletionAdapter.deleteAndReturnChangedRows(model);
  }
}

class _$TeamGameDao extends TeamGameDao {
  _$TeamGameDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _teamGameInsertionAdapter = InsertionAdapter(
            database,
            'team_games',
            (TeamGame item) => <String, dynamic>{
                  'teamId': item.teamId,
                  'gameId': item.gameId,
                  'saved': item.saved == null ? null : (item.saved ? 1 : 0),
                  'deleted':
                      item.deleted == null ? null : (item.deleted ? 1 : 0)
                },
            changeListener),
        _teamGameUpdateAdapter = UpdateAdapter(
            database,
            'team_games',
            ['teamId', 'gameId'],
            (TeamGame item) => <String, dynamic>{
                  'teamId': item.teamId,
                  'gameId': item.gameId,
                  'saved': item.saved == null ? null : (item.saved ? 1 : 0),
                  'deleted':
                      item.deleted == null ? null : (item.deleted ? 1 : 0)
                },
            changeListener),
        _teamGameDeletionAdapter = DeletionAdapter(
            database,
            'team_games',
            ['teamId', 'gameId'],
            (TeamGame item) => <String, dynamic>{
                  'teamId': item.teamId,
                  'gameId': item.gameId,
                  'saved': item.saved == null ? null : (item.saved ? 1 : 0),
                  'deleted':
                      item.deleted == null ? null : (item.deleted ? 1 : 0)
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _team_gamesMapper = (Map<String, dynamic> row) => TeamGame(
      teamId: row['teamId'] as String,
      gameId: row['gameId'] as String,
      saved: row['saved'] == null ? null : (row['saved'] as int) != 0,
      deleted: row['deleted'] == null ? null : (row['deleted'] as int) != 0);

  final InsertionAdapter<TeamGame> _teamGameInsertionAdapter;

  final UpdateAdapter<TeamGame> _teamGameUpdateAdapter;

  final DeletionAdapter<TeamGame> _teamGameDeletionAdapter;

  @override
  Stream<List<TeamGame>> getStream(String teamId) {
    return _queryAdapter.queryListStream(
        'select * from team_games where teamId = ? and deleted = 0',
        arguments: <dynamic>[teamId],
        queryableName: 'team_games',
        isView: false,
        mapper: _team_gamesMapper);
  }

  @override
  Future<List<TeamGame>> getList(String teamId) async {
    return _queryAdapter.queryList(
        'select * from team_games where teamId = ? and deleted = 0',
        arguments: <dynamic>[teamId],
        mapper: _team_gamesMapper);
  }

  @override
  Future<List<TeamGame>> getSaved(String teamId) async {
    return _queryAdapter.queryList(
        'select * from team_games where teamId = ? and saved = 1 and deleted = 0',
        arguments: <dynamic>[teamId],
        mapper: _team_gamesMapper);
  }

  @override
  Future<List<TeamGame>> getUnsaved(String teamId) async {
    return _queryAdapter.queryList(
        'select * from team_games where teamId = ? and saved = 0 and deleted = 0',
        arguments: <dynamic>[teamId],
        mapper: _team_gamesMapper);
  }

  @override
  Future<List<TeamGame>> getUndeleted(String teamId) async {
    return _queryAdapter.queryList(
        'select * from team_games where teamId = ? and deleted = 1',
        arguments: <dynamic>[teamId],
        mapper: _team_gamesMapper);
  }

  @override
  Future<int> insertModel(TeamGame model) {
    return _teamGameInsertionAdapter.insertAndReturnId(
        model, OnConflictStrategy.replace);
  }

  @override
  Future<int> updateModel(TeamGame model) {
    return _teamGameUpdateAdapter.updateAndReturnChangedRows(
        model, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteModel(TeamGame model) {
    return _teamGameDeletionAdapter.deleteAndReturnChangedRows(model);
  }
}
