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

  EventTypeDao _eventTypeDaoInstance;

  DiscrepancyDao _discrepancyDaoInstance;

  GameDao _gameDaoInstance;

  PlayerStatsDao _playerStatsDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `team_players` (`teamId` TEXT, `playerId` TEXT, `saved` INTEGER, `deleted` INTEGER, PRIMARY KEY (`teamId`, `playerId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `events` (`id` TEXT, `teamId` TEXT, `start` TEXT, `end` TEXT, `name` TEXT, `description` TEXT, `type` INTEGER, `currentHasConfirmed` INTEGER, `saved` INTEGER, `create` INTEGER, `deleted` INTEGER, FOREIGN KEY (`teamId`) REFERENCES `teams` (`id`) ON UPDATE CASCADE ON DELETE CASCADE, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `event_types` (`index` INTEGER, `name` TEXT, PRIMARY KEY (`index`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `discrepancies` (`id` TEXT, `type` INTEGER, `reason` TEXT, `userId` TEXT, `username` TEXT, `delayLength` INTEGER, `eventId` TEXT, `saved` INTEGER, `create` INTEGER, `deleted` INTEGER, FOREIGN KEY (`eventId`) REFERENCES `events` (`id`) ON UPDATE CASCADE ON DELETE CASCADE, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `games` (`id` TEXT, `name` TEXT, `date` TEXT, `win` INTEGER, `teamId` TEXT, `saved` INTEGER, `create` INTEGER, `deleted` INTEGER, FOREIGN KEY (`teamId`) REFERENCES `teams` (`id`) ON UPDATE CASCADE ON DELETE CASCADE, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `player_stats` (`id` TEXT, `player` TEXT, `goals` INTEGER, `saves` INTEGER, `shots` INTEGER, `assists` INTEGER, `score` INTEGER, `goalShots` INTEGER, `created` TEXT, `gameId` TEXT, FOREIGN KEY (`gameId`) REFERENCES `games` (`id`) ON UPDATE CASCADE ON DELETE CASCADE, PRIMARY KEY (`id`))');
        await database
            .execute('CREATE INDEX `index_teams_player` ON `teams` (`player`)');
        await database.execute(
            'CREATE INDEX `index_team_players_teamId` ON `team_players` (`teamId`)');
        await database.execute(
            'CREATE INDEX `index_team_players_playerId` ON `team_players` (`playerId`)');

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
  EventTypeDao get eventTypeDao {
    return _eventTypeDaoInstance ??= _$EventTypeDao(database, changeListener);
  }

  @override
  DiscrepancyDao get discrepancyDao {
    return _discrepancyDaoInstance ??=
        _$DiscrepancyDao(database, changeListener);
  }

  @override
  GameDao get gameDao {
    return _gameDaoInstance ??= _$GameDao(database, changeListener);
  }

  @override
  PlayerStatsDao get playerStatsDao {
    return _playerStatsDaoInstance ??=
        _$PlayerStatsDao(database, changeListener);
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
        'select * from players p inner join team_players tp on p.id = tp.playerId and tp.teamId = ? and tp.playerId != ? and tp.deleted = 0',
        arguments: <dynamic>[teamId, managerId],
        queryableName: 'players',
        isView: false,
        mapper: _playersMapper);
  }

  @override
  Future<List<Player>> getList(String teamId, String managerId) async {
    return _queryAdapter.queryList(
        'select * from players inner join team_players on players.id = team_players.playerId and team_players.teamId = ? and team_players.playerId != ? and team_players.deleted = 0',
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
                  'teamId': item.teamId,
                  'start': item.start,
                  'end': item.end,
                  'name': item.name,
                  'description': item.description,
                  'type': item.type,
                  'currentHasConfirmed': item.currentHasConfirmed == null
                      ? null
                      : (item.currentHasConfirmed ? 1 : 0),
                  'saved': item.saved == null ? null : (item.saved ? 1 : 0),
                  'create': item.create == null ? null : (item.create ? 1 : 0),
                  'deleted':
                      item.deleted == null ? null : (item.deleted ? 1 : 0)
                },
            changeListener),
        _eventUpdateAdapter = UpdateAdapter(
            database,
            'events',
            ['id'],
            (Event item) => <String, dynamic>{
                  'id': item.id,
                  'teamId': item.teamId,
                  'start': item.start,
                  'end': item.end,
                  'name': item.name,
                  'description': item.description,
                  'type': item.type,
                  'currentHasConfirmed': item.currentHasConfirmed == null
                      ? null
                      : (item.currentHasConfirmed ? 1 : 0),
                  'saved': item.saved == null ? null : (item.saved ? 1 : 0),
                  'create': item.create == null ? null : (item.create ? 1 : 0),
                  'deleted':
                      item.deleted == null ? null : (item.deleted ? 1 : 0)
                },
            changeListener),
        _eventDeletionAdapter = DeletionAdapter(
            database,
            'events',
            ['id'],
            (Event item) => <String, dynamic>{
                  'id': item.id,
                  'teamId': item.teamId,
                  'start': item.start,
                  'end': item.end,
                  'name': item.name,
                  'description': item.description,
                  'type': item.type,
                  'currentHasConfirmed': item.currentHasConfirmed == null
                      ? null
                      : (item.currentHasConfirmed ? 1 : 0),
                  'saved': item.saved == null ? null : (item.saved ? 1 : 0),
                  'create': item.create == null ? null : (item.create ? 1 : 0),
                  'deleted':
                      item.deleted == null ? null : (item.deleted ? 1 : 0)
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _eventsMapper = (Map<String, dynamic> row) => Event(
      id: row['id'] as String,
      teamId: row['teamId'] as String,
      start: row['start'] as String,
      end: row['end'] as String,
      name: row['name'] as String,
      description: row['description'] as String,
      type: row['type'] as int,
      currentHasConfirmed: row['currentHasConfirmed'] == null
          ? null
          : (row['currentHasConfirmed'] as int) != 0,
      saved: row['saved'] == null ? null : (row['saved'] as int) != 0,
      create: row['create'] == null ? null : (row['create'] as int) != 0,
      deleted: row['deleted'] == null ? null : (row['deleted'] as int) != 0);

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
        'select * from events where teamId = ? and deleted = 0',
        arguments: <dynamic>[teamId],
        queryableName: 'events',
        isView: false,
        mapper: _eventsMapper);
  }

  @override
  Future<List<Event>> getList(String teamId) async {
    return _queryAdapter.queryList(
        'select * from events where teamId = ? and deleted = 0',
        arguments: <dynamic>[teamId],
        mapper: _eventsMapper);
  }

  @override
  Future<List<Event>> getSaved(String teamId) async {
    return _queryAdapter.queryList(
        'select * from events where teamId = ? and saved = 1 and deleted = 0',
        arguments: <dynamic>[teamId],
        mapper: _eventsMapper);
  }

  @override
  Future<List<Event>> getUnsaved(String teamId) async {
    return _queryAdapter.queryList(
        'select * from events where teamId = ? and saved = 0 and deleted = 0',
        arguments: <dynamic>[teamId],
        mapper: _eventsMapper);
  }

  @override
  Future<List<Event>> getUndeleted(String teamId) async {
    return _queryAdapter.queryList(
        'select * from events where teamId = ? and deleted = 1',
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

class _$EventTypeDao extends EventTypeDao {
  _$EventTypeDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _eventTypeInsertionAdapter = InsertionAdapter(
            database,
            'event_types',
            (EventType item) =>
                <String, dynamic>{'index': item.index, 'name': item.name}),
        _eventTypeUpdateAdapter = UpdateAdapter(
            database,
            'event_types',
            ['index'],
            (EventType item) =>
                <String, dynamic>{'index': item.index, 'name': item.name}),
        _eventTypeDeletionAdapter = DeletionAdapter(
            database,
            'event_types',
            ['index'],
            (EventType item) =>
                <String, dynamic>{'index': item.index, 'name': item.name});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _event_typesMapper = (Map<String, dynamic> row) =>
      EventType(index: row['index'] as int, name: row['name'] as String);

  final InsertionAdapter<EventType> _eventTypeInsertionAdapter;

  final UpdateAdapter<EventType> _eventTypeUpdateAdapter;

  final DeletionAdapter<EventType> _eventTypeDeletionAdapter;

  @override
  Future<List<EventType>> get() async {
    return _queryAdapter.queryList('select * from event_types',
        mapper: _event_typesMapper);
  }

  @override
  Future<int> insertModel(EventType model) {
    return _eventTypeInsertionAdapter.insertAndReturnId(
        model, OnConflictStrategy.replace);
  }

  @override
  Future<int> updateModel(EventType model) {
    return _eventTypeUpdateAdapter.updateAndReturnChangedRows(
        model, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteModel(EventType model) {
    return _eventTypeDeletionAdapter.deleteAndReturnChangedRows(model);
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
                  'eventId': item.eventId,
                  'saved': item.saved == null ? null : (item.saved ? 1 : 0),
                  'create': item.create == null ? null : (item.create ? 1 : 0),
                  'deleted':
                      item.deleted == null ? null : (item.deleted ? 1 : 0)
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
                  'eventId': item.eventId,
                  'saved': item.saved == null ? null : (item.saved ? 1 : 0),
                  'create': item.create == null ? null : (item.create ? 1 : 0),
                  'deleted':
                      item.deleted == null ? null : (item.deleted ? 1 : 0)
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
                  'eventId': item.eventId,
                  'saved': item.saved == null ? null : (item.saved ? 1 : 0),
                  'create': item.create == null ? null : (item.create ? 1 : 0),
                  'deleted':
                      item.deleted == null ? null : (item.deleted ? 1 : 0)
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
      saved: row['saved'] == null ? null : (row['saved'] as int) != 0,
      create: row['create'] == null ? null : (row['create'] as int) != 0,
      deleted: row['deleted'] == null ? null : (row['deleted'] as int) != 0);

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
        'select * from discrepancies where eventId = ? and deleted = 0',
        arguments: <dynamic>[eventId],
        queryableName: 'discrepancies',
        isView: false,
        mapper: _discrepanciesMapper);
  }

  @override
  Future<List<Discrepancy>> getList(String eventId) async {
    return _queryAdapter.queryList(
        'select * from discrepancies where eventId = ? and deleted = 0',
        arguments: <dynamic>[eventId],
        mapper: _discrepanciesMapper);
  }

  @override
  Future<List<Discrepancy>> getSaved(String eventId) async {
    return _queryAdapter.queryList(
        'select * from discrepancies where eventId = ? and saved = 1 and deleted = 0',
        arguments: <dynamic>[eventId],
        mapper: _discrepanciesMapper);
  }

  @override
  Future<List<Discrepancy>> getUnsaved(String eventId) async {
    return _queryAdapter.queryList(
        'select * from discrepancies where eventId = ? and saved = 0 and deleted = 0',
        arguments: <dynamic>[eventId],
        mapper: _discrepanciesMapper);
  }

  @override
  Future<List<Discrepancy>> getUndeleted(String eventId) async {
    return _queryAdapter.queryList(
        'select * from discrepancies where eventId = ? and deleted = 1',
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
                  'win': item.win,
                  'teamId': item.teamId,
                  'saved': item.saved == null ? null : (item.saved ? 1 : 0),
                  'create': item.create == null ? null : (item.create ? 1 : 0),
                  'deleted':
                      item.deleted == null ? null : (item.deleted ? 1 : 0)
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
                  'win': item.win,
                  'teamId': item.teamId,
                  'saved': item.saved == null ? null : (item.saved ? 1 : 0),
                  'create': item.create == null ? null : (item.create ? 1 : 0),
                  'deleted':
                      item.deleted == null ? null : (item.deleted ? 1 : 0)
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
                  'win': item.win,
                  'teamId': item.teamId,
                  'saved': item.saved == null ? null : (item.saved ? 1 : 0),
                  'create': item.create == null ? null : (item.create ? 1 : 0),
                  'deleted':
                      item.deleted == null ? null : (item.deleted ? 1 : 0)
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _gamesMapper = (Map<String, dynamic> row) => Game(
      id: row['id'] as String,
      name: row['name'] as String,
      date: row['date'] as String,
      win: row['win'] as int,
      teamId: row['teamId'] as String,
      saved: row['saved'] == null ? null : (row['saved'] as int) != 0,
      create: row['create'] == null ? null : (row['create'] as int) != 0,
      deleted: row['deleted'] == null ? null : (row['deleted'] as int) != 0);

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
        'select * from games where teamId = ? and deleted = 0',
        arguments: <dynamic>[teamId],
        queryableName: 'games',
        isView: false,
        mapper: _gamesMapper);
  }

  @override
  Future<List<Game>> getList(String teamId) async {
    return _queryAdapter.queryList(
        'select * from games where teamId = ? and deleted = 0',
        arguments: <dynamic>[teamId],
        mapper: _gamesMapper);
  }

  @override
  Future<List<Game>> getSaved(String teamId) async {
    return _queryAdapter.queryList(
        'select * from games where teamId = ? and saved = 1 and deleted = 0',
        arguments: <dynamic>[teamId],
        mapper: _gamesMapper);
  }

  @override
  Future<List<Game>> getUnsaved(String teamId) async {
    return _queryAdapter.queryList(
        'select * from games where teamId = ? and saved = 0 and deleted = 0',
        arguments: <dynamic>[teamId],
        mapper: _gamesMapper);
  }

  @override
  Future<List<Game>> getUndeleted(String teamId) async {
    return _queryAdapter.queryList(
        'select * from games where teamId = ? and deleted = 1',
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

class _$PlayerStatsDao extends PlayerStatsDao {
  _$PlayerStatsDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _playerStatsInsertionAdapter = InsertionAdapter(
            database,
            'player_stats',
            (PlayerStats item) => <String, dynamic>{
                  'id': item.id,
                  'player': item.player,
                  'goals': item.goals,
                  'saves': item.saves,
                  'shots': item.shots,
                  'assists': item.assists,
                  'score': item.score,
                  'goalShots': item.goalShots,
                  'created': item.created,
                  'gameId': item.gameId
                }),
        _playerStatsUpdateAdapter = UpdateAdapter(
            database,
            'player_stats',
            ['id'],
            (PlayerStats item) => <String, dynamic>{
                  'id': item.id,
                  'player': item.player,
                  'goals': item.goals,
                  'saves': item.saves,
                  'shots': item.shots,
                  'assists': item.assists,
                  'score': item.score,
                  'goalShots': item.goalShots,
                  'created': item.created,
                  'gameId': item.gameId
                }),
        _playerStatsDeletionAdapter = DeletionAdapter(
            database,
            'player_stats',
            ['id'],
            (PlayerStats item) => <String, dynamic>{
                  'id': item.id,
                  'player': item.player,
                  'goals': item.goals,
                  'saves': item.saves,
                  'shots': item.shots,
                  'assists': item.assists,
                  'score': item.score,
                  'goalShots': item.goalShots,
                  'created': item.created,
                  'gameId': item.gameId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _player_statsMapper = (Map<String, dynamic> row) => PlayerStats(
      id: row['id'] as String,
      player: row['player'] as String,
      goals: row['goals'] as int,
      saves: row['saves'] as int,
      shots: row['shots'] as int,
      assists: row['assists'] as int,
      score: row['score'] as int,
      goalShots: row['goalShots'] as int,
      created: row['created'] as String,
      gameId: row['gameId'] as String);

  final InsertionAdapter<PlayerStats> _playerStatsInsertionAdapter;

  final UpdateAdapter<PlayerStats> _playerStatsUpdateAdapter;

  final DeletionAdapter<PlayerStats> _playerStatsDeletionAdapter;

  @override
  Future<List<PlayerStats>> getList(String gameId) async {
    return _queryAdapter.queryList(
        'select * from player_stats where gameId = ? order by score',
        arguments: <dynamic>[gameId],
        mapper: _player_statsMapper);
  }

  @override
  Future<int> insertModel(PlayerStats model) {
    return _playerStatsInsertionAdapter.insertAndReturnId(
        model, OnConflictStrategy.replace);
  }

  @override
  Future<int> updateModel(PlayerStats model) {
    return _playerStatsUpdateAdapter.updateAndReturnChangedRows(
        model, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteModel(PlayerStats model) {
    return _playerStatsDeletionAdapter.deleteAndReturnChangedRows(model);
  }
}
