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

  GameDao _gameDaoInstance;

  TeamGameDao _teamGameDaoInstance;

  DiscrepancyDao _discrepancyDaoInstance;

  EventDiscrepancyDao _eventDiscrepancyDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `teams` (`id` TEXT, `player` TEXT, `name` TEXT, `description` TEXT, `image` TEXT, `managerId` TEXT, `created` TEXT, `save` INTEGER, `update` INTEGER, `delete` INTEGER, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `players` (`id` TEXT, `username` TEXT, `email` TEXT, `image` TEXT, `created` TEXT, `calendarSecret` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `team_players` (`teamId` TEXT, `playerId` TEXT, `save` INTEGER, `delete` INTEGER, FOREIGN KEY (`teamId`) REFERENCES `teams` (`id`) ON UPDATE CASCADE ON DELETE CASCADE, FOREIGN KEY (`playerId`) REFERENCES `players` (`id`) ON UPDATE CASCADE ON DELETE CASCADE, PRIMARY KEY (`teamId`, `playerId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `games` (`id` TEXT, `name` TEXT, `date` TEXT, `win` INTEGER, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `teams_gamess` (`teamId` TEXT, `gameId` TEXT, `save` INTEGER, `delete` INTEGER, FOREIGN KEY (`teamId`) REFERENCES `teams` (`id`) ON UPDATE CASCADE ON DELETE CASCADE, FOREIGN KEY (`gameId`) REFERENCES `games` (`id`) ON UPDATE CASCADE ON DELETE CASCADE, PRIMARY KEY (`teamId`, `gameId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `events` (`id` TEXT, `team` TEXT, `start` TEXT, `end` TEXT, `name` TEXT, `description` TEXT, `type` INTEGER, `save` INTEGER, `update` INTEGER, `delete` INTEGER, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `teams_events` (`teamId` TEXT, `eventId` TEXT, `save` INTEGER, `delete` INTEGER, FOREIGN KEY (`teamId`) REFERENCES `teams` (`id`) ON UPDATE CASCADE ON DELETE CASCADE, FOREIGN KEY (`eventId`) REFERENCES `events` (`id`) ON UPDATE CASCADE ON DELETE CASCADE, PRIMARY KEY (`teamId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `discrepancies` (`id` TEXT, `type` INTEGER, `reason` TEXT, `delayLength` INTEGER, `event` TEXT, `save` INTEGER, `update` INTEGER, `delete` INTEGER, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `events_discrepancies` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `eventId` TEXT, `discrepancyId` TEXT, `confirmed` INTEGER, `save` INTEGER, `delete` INTEGER, FOREIGN KEY (`eventId`) REFERENCES `events` (`id`) ON UPDATE CASCADE ON DELETE CASCADE, FOREIGN KEY (`discrepancyId`) REFERENCES `discrepancies` (`id`) ON UPDATE CASCADE ON DELETE CASCADE)');
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
  GameDao get gameDao {
    return _gameDaoInstance ??= _$GameDao(database, changeListener);
  }

  @override
  TeamGameDao get teamGameDao {
    return _teamGameDaoInstance ??= _$TeamGameDao(database, changeListener);
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
                  'save': item.save == null ? null : (item.save ? 1 : 0),
                  'update': item.update == null ? null : (item.update ? 1 : 0),
                  'delete': item.delete == null ? null : (item.delete ? 1 : 0)
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
                  'save': item.save == null ? null : (item.save ? 1 : 0),
                  'update': item.update == null ? null : (item.update ? 1 : 0),
                  'delete': item.delete == null ? null : (item.delete ? 1 : 0)
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
                  'save': item.save == null ? null : (item.save ? 1 : 0),
                  'update': item.update == null ? null : (item.update ? 1 : 0),
                  'delete': item.delete == null ? null : (item.delete ? 1 : 0)
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
      save: row['save'] == null ? null : (row['save'] as int) != 0,
      update: row['update'] == null ? null : (row['update'] as int) != 0,
      delete: row['delete'] == null ? null : (row['delete'] as int) != 0);

  final InsertionAdapter<Team> _teamInsertionAdapter;

  final UpdateAdapter<Team> _teamUpdateAdapter;

  final DeletionAdapter<Team> _teamDeletionAdapter;

  @override
  Stream<List<Team>> getTeams(String player) {
    return _queryAdapter.queryListStream(
        'select * from teams where player = ? and `delete` = 0 order by name',
        arguments: <dynamic>[player],
        queryableName: 'teams',
        isView: false,
        mapper: _teamsMapper);
  }

  @override
  Future<List<Team>> getSavedTeams(String player) async {
    return _queryAdapter.queryList(
        'select * from teams where player = ? and save = 1 and `delete` = 0',
        arguments: <dynamic>[player],
        mapper: _teamsMapper);
  }

  @override
  Future<List<Team>> getUnsavedTeams(String player) async {
    return _queryAdapter.queryList(
        'select * from teams where player = ? and save = 0 and `delete` = 0',
        arguments: <dynamic>[player],
        mapper: _teamsMapper);
  }

  @override
  Future<List<Team>> getUndeletedTeams(String player) async {
    return _queryAdapter.queryList(
        'select * from teams where player = ? and `delete` = 1',
        arguments: <dynamic>[player],
        mapper: _teamsMapper);
  }

  @override
  Future<void> updateTeamId(String oldId, String newId, int save) async {
    await _queryAdapter.queryNoReturn(
        'update teams set id = ?, save = ? where id = ?',
        arguments: <dynamic>[oldId, newId, save]);
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
  Stream<List<Player>> getPlayers(List<String> ids) {
    final valueList1 = ids.map((value) => "'$value'").join(', ');
    return _queryAdapter.queryListStream(
        'select * from players where id in ($valueList1)',
        queryableName: 'players',
        isView: false,
        mapper: _playersMapper);
  }

  @override
  Future<Player> getPlayer(String id) async {
    return _queryAdapter.query('select * from players where id = ?',
        arguments: <dynamic>[id], mapper: _playersMapper);
  }

  @override
  Future<void> updatePlayerId(String oldId, String newId) async {
    await _queryAdapter.queryNoReturn('update players set id = ? where id = ?',
        arguments: <dynamic>[oldId, newId]);
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
                  'save': item.save == null ? null : (item.save ? 1 : 0),
                  'delete': item.delete == null ? null : (item.delete ? 1 : 0)
                },
            changeListener),
        _teamPlayerUpdateAdapter = UpdateAdapter(
            database,
            'team_players',
            ['teamId', 'playerId'],
            (TeamPlayer item) => <String, dynamic>{
                  'teamId': item.teamId,
                  'playerId': item.playerId,
                  'save': item.save == null ? null : (item.save ? 1 : 0),
                  'delete': item.delete == null ? null : (item.delete ? 1 : 0)
                },
            changeListener),
        _teamPlayerDeletionAdapter = DeletionAdapter(
            database,
            'team_players',
            ['teamId', 'playerId'],
            (TeamPlayer item) => <String, dynamic>{
                  'teamId': item.teamId,
                  'playerId': item.playerId,
                  'save': item.save == null ? null : (item.save ? 1 : 0),
                  'delete': item.delete == null ? null : (item.delete ? 1 : 0)
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _team_playersMapper = (Map<String, dynamic> row) => TeamPlayer(
      teamId: row['teamId'] as String,
      playerId: row['playerId'] as String,
      save: row['save'] == null ? null : (row['save'] as int) != 0,
      delete: row['delete'] == null ? null : (row['delete'] as int) != 0);

  final InsertionAdapter<TeamPlayer> _teamPlayerInsertionAdapter;

  final UpdateAdapter<TeamPlayer> _teamPlayerUpdateAdapter;

  final DeletionAdapter<TeamPlayer> _teamPlayerDeletionAdapter;

  @override
  Stream<List<TeamPlayer>> getTeamPlayers(String teamId) {
    return _queryAdapter.queryListStream(
        'select * from teams_players where teamId = ? and `delete` = 0',
        arguments: <dynamic>[teamId],
        queryableName: 'team_players',
        isView: false,
        mapper: _team_playersMapper);
  }

  @override
  Future<List<TeamPlayer>> getAllTeamPlayers(String teamId) async {
    return _queryAdapter.queryList(
        'select * from teams_players where teamId = ? and `delete` = 0',
        arguments: <dynamic>[teamId],
        mapper: _team_playersMapper);
  }

  @override
  Future<List<TeamPlayer>> getSavedTeamPlayers(String teamId) async {
    return _queryAdapter.queryList(
        'select * from teams_players where teamId = ? and save = 1 and `delete` = 0',
        arguments: <dynamic>[teamId],
        mapper: _team_playersMapper);
  }

  @override
  Future<List<TeamPlayer>> getUnsavedTeamPlayers(String teamId) async {
    return _queryAdapter.queryList(
        'select * from teams_players where teamId = ? and save = 0 and `delete` = 0',
        arguments: <dynamic>[teamId],
        mapper: _team_playersMapper);
  }

  @override
  Future<List<TeamPlayer>> getUndeletedTeamPlayers(String teamId) async {
    return _queryAdapter.queryList(
        'select * from teams_players where teamId = ? and `delete` = 1',
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
                  'save': item.save == null ? null : (item.save ? 1 : 0),
                  'update': item.update == null ? null : (item.update ? 1 : 0),
                  'delete': item.delete == null ? null : (item.delete ? 1 : 0)
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
                  'save': item.save == null ? null : (item.save ? 1 : 0),
                  'update': item.update == null ? null : (item.update ? 1 : 0),
                  'delete': item.delete == null ? null : (item.delete ? 1 : 0)
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
                  'save': item.save == null ? null : (item.save ? 1 : 0),
                  'update': item.update == null ? null : (item.update ? 1 : 0),
                  'delete': item.delete == null ? null : (item.delete ? 1 : 0)
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
      save: row['save'] == null ? null : (row['save'] as int) != 0,
      update: row['update'] == null ? null : (row['update'] as int) != 0,
      delete: row['delete'] == null ? null : (row['delete'] as int) != 0);

  final InsertionAdapter<Event> _eventInsertionAdapter;

  final UpdateAdapter<Event> _eventUpdateAdapter;

  final DeletionAdapter<Event> _eventDeletionAdapter;

  @override
  Stream<List<Event>> getEvents(String team) {
    return _queryAdapter.queryListStream(
        'select * from events where team = ? and `delete` = 0',
        arguments: <dynamic>[team],
        queryableName: 'events',
        isView: false,
        mapper: _eventsMapper);
  }

  @override
  Future<List<Event>> getSavedEvents(String team) async {
    return _queryAdapter.queryList(
        'select * from events where team = ? and save = 1 and `delete` = 0',
        arguments: <dynamic>[team],
        mapper: _eventsMapper);
  }

  @override
  Future<List<Event>> getUnsavedEvents(String team) async {
    return _queryAdapter.queryList(
        'select * from events where team = ? and save = 0 and `delete` = 0',
        arguments: <dynamic>[team],
        mapper: _eventsMapper);
  }

  @override
  Future<List<Event>> getUndeletedEvents(String team) async {
    return _queryAdapter.queryList(
        'select * from events where team = ? and `delete` = 1',
        arguments: <dynamic>[team],
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
            'teams_events',
            (TeamEvent item) => <String, dynamic>{
                  'teamId': item.teamId,
                  'eventId': item.eventId,
                  'save': item.save == null ? null : (item.save ? 1 : 0),
                  'delete': item.delete == null ? null : (item.delete ? 1 : 0)
                },
            changeListener),
        _teamEventUpdateAdapter = UpdateAdapter(
            database,
            'teams_events',
            ['teamId'],
            (TeamEvent item) => <String, dynamic>{
                  'teamId': item.teamId,
                  'eventId': item.eventId,
                  'save': item.save == null ? null : (item.save ? 1 : 0),
                  'delete': item.delete == null ? null : (item.delete ? 1 : 0)
                },
            changeListener),
        _teamEventDeletionAdapter = DeletionAdapter(
            database,
            'teams_events',
            ['teamId'],
            (TeamEvent item) => <String, dynamic>{
                  'teamId': item.teamId,
                  'eventId': item.eventId,
                  'save': item.save == null ? null : (item.save ? 1 : 0),
                  'delete': item.delete == null ? null : (item.delete ? 1 : 0)
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _teams_eventsMapper = (Map<String, dynamic> row) => TeamEvent(
      teamId: row['teamId'] as String,
      eventId: row['eventId'] as String,
      save: row['save'] == null ? null : (row['save'] as int) != 0,
      delete: row['delete'] == null ? null : (row['delete'] as int) != 0);

  final InsertionAdapter<TeamEvent> _teamEventInsertionAdapter;

  final UpdateAdapter<TeamEvent> _teamEventUpdateAdapter;

  final DeletionAdapter<TeamEvent> _teamEventDeletionAdapter;

  @override
  Stream<List<TeamEvent>> getTeamEvents(String teamId) {
    return _queryAdapter.queryListStream(
        'select * from team_events where teamId = ? and `delete` = 0',
        arguments: <dynamic>[teamId],
        queryableName: 'teams_events',
        isView: false,
        mapper: _teams_eventsMapper);
  }

  @override
  Future<List<TeamEvent>> getAllTeamEvents(String teamId) async {
    return _queryAdapter.queryList(
        'select * from team_events where teamId = ? and `delete` = 0',
        arguments: <dynamic>[teamId],
        mapper: _teams_eventsMapper);
  }

  @override
  Future<List<TeamEvent>> getSavedTeamEvents(String teamId) async {
    return _queryAdapter.queryList(
        'select * from team_events where teamId = ? and save = 1 and `delete` = 0',
        arguments: <dynamic>[teamId],
        mapper: _teams_eventsMapper);
  }

  @override
  Future<List<TeamEvent>> getUnsavedTeamEvents(String teamId) async {
    return _queryAdapter.queryList(
        'select * from team_events where teamId = ? and save = 0 and `delete` = 0',
        arguments: <dynamic>[teamId],
        mapper: _teams_eventsMapper);
  }

  @override
  Future<List<TeamEvent>> getUndeletedTeamEvents(String teamId) async {
    return _queryAdapter.queryList(
        'select * from team_events where teamId = ? and `delete` = 1',
        arguments: <dynamic>[teamId],
        mapper: _teams_eventsMapper);
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
  Stream<List<Game>> getGames(String team) {
    return _queryAdapter.queryListStream(
        'select * from events where team = ? and `delete` = 0',
        arguments: <dynamic>[team],
        queryableName: 'games',
        isView: false,
        mapper: _gamesMapper);
  }

  @override
  Future<List<Game>> getSavedGames(String team) async {
    return _queryAdapter.queryList(
        'select * from events where team = ? and save = 1 and `delete` = 0',
        arguments: <dynamic>[team],
        mapper: _gamesMapper);
  }

  @override
  Future<List<Game>> getUnsavedGames(String team) async {
    return _queryAdapter.queryList(
        'select * from events where team = ? and save = 0 and `delete` = 0',
        arguments: <dynamic>[team],
        mapper: _gamesMapper);
  }

  @override
  Future<List<Game>> getUndeletedGames(String team) async {
    return _queryAdapter.queryList(
        'select * from events where team = ? and `delete` = 1',
        arguments: <dynamic>[team],
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
            'teams_gamess',
            (TeamGame item) => <String, dynamic>{
                  'teamId': item.teamId,
                  'gameId': item.gameId,
                  'save': item.save == null ? null : (item.save ? 1 : 0),
                  'delete': item.delete == null ? null : (item.delete ? 1 : 0)
                },
            changeListener),
        _teamGameUpdateAdapter = UpdateAdapter(
            database,
            'teams_gamess',
            ['teamId', 'gameId'],
            (TeamGame item) => <String, dynamic>{
                  'teamId': item.teamId,
                  'gameId': item.gameId,
                  'save': item.save == null ? null : (item.save ? 1 : 0),
                  'delete': item.delete == null ? null : (item.delete ? 1 : 0)
                },
            changeListener),
        _teamGameDeletionAdapter = DeletionAdapter(
            database,
            'teams_gamess',
            ['teamId', 'gameId'],
            (TeamGame item) => <String, dynamic>{
                  'teamId': item.teamId,
                  'gameId': item.gameId,
                  'save': item.save == null ? null : (item.save ? 1 : 0),
                  'delete': item.delete == null ? null : (item.delete ? 1 : 0)
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _teams_gamessMapper = (Map<String, dynamic> row) => TeamGame(
      teamId: row['teamId'] as String,
      gameId: row['gameId'] as String,
      save: row['save'] == null ? null : (row['save'] as int) != 0,
      delete: row['delete'] == null ? null : (row['delete'] as int) != 0);

  final InsertionAdapter<TeamGame> _teamGameInsertionAdapter;

  final UpdateAdapter<TeamGame> _teamGameUpdateAdapter;

  final DeletionAdapter<TeamGame> _teamGameDeletionAdapter;

  @override
  Stream<List<TeamGame>> getTeamGames(String teamId) {
    return _queryAdapter.queryListStream(
        'select * from team_games where teamId = ? and `delete` = 0',
        arguments: <dynamic>[teamId],
        queryableName: 'teams_gamess',
        isView: false,
        mapper: _teams_gamessMapper);
  }

  @override
  Future<List<TeamGame>> getAllTeamGames(String teamId) async {
    return _queryAdapter.queryList(
        'select * from team_games where teamId = ? and `delete` = 0',
        arguments: <dynamic>[teamId],
        mapper: _teams_gamessMapper);
  }

  @override
  Future<List<TeamGame>> getSavedTeamGames(String teamId) async {
    return _queryAdapter.queryList(
        'select * from team_games where teamId = ? and save = 1 and `delete` = 0',
        arguments: <dynamic>[teamId],
        mapper: _teams_gamessMapper);
  }

  @override
  Future<List<TeamGame>> getUnsavedTeamGames(String teamId) async {
    return _queryAdapter.queryList(
        'select * from team_games where teamId = ? and save = 0 and `delete` = 0',
        arguments: <dynamic>[teamId],
        mapper: _teams_gamessMapper);
  }

  @override
  Future<List<TeamGame>> getUndeletedTeamGames(String teamId) async {
    return _queryAdapter.queryList(
        'select * from team_games where teamId = ? and `delete` = 1',
        arguments: <dynamic>[teamId],
        mapper: _teams_gamessMapper);
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
                  'delayLength': item.delayLength,
                  'event': item.event,
                  'save': item.save == null ? null : (item.save ? 1 : 0),
                  'update': item.update == null ? null : (item.update ? 1 : 0),
                  'delete': item.delete == null ? null : (item.delete ? 1 : 0)
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
                  'delayLength': item.delayLength,
                  'event': item.event,
                  'save': item.save == null ? null : (item.save ? 1 : 0),
                  'update': item.update == null ? null : (item.update ? 1 : 0),
                  'delete': item.delete == null ? null : (item.delete ? 1 : 0)
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
                  'delayLength': item.delayLength,
                  'event': item.event,
                  'save': item.save == null ? null : (item.save ? 1 : 0),
                  'update': item.update == null ? null : (item.update ? 1 : 0),
                  'delete': item.delete == null ? null : (item.delete ? 1 : 0)
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _discrepanciesMapper = (Map<String, dynamic> row) => Discrepancy(
      id: row['id'] as String,
      save: row['save'] == null ? null : (row['save'] as int) != 0,
      update: row['update'] == null ? null : (row['update'] as int) != 0,
      delete: row['delete'] == null ? null : (row['delete'] as int) != 0);

  final InsertionAdapter<Discrepancy> _discrepancyInsertionAdapter;

  final UpdateAdapter<Discrepancy> _discrepancyUpdateAdapter;

  final DeletionAdapter<Discrepancy> _discrepancyDeletionAdapter;

  @override
  Stream<List<Discrepancy>> getDiscrepancies(String eventId) {
    return _queryAdapter.queryListStream(
        'select * from discrepancies where eventId = ? and `delete` = 0',
        arguments: <dynamic>[eventId],
        queryableName: 'discrepancies',
        isView: false,
        mapper: _discrepanciesMapper);
  }

  @override
  Future<List<Discrepancy>> getSavedDiscrepancies(String eventId) async {
    return _queryAdapter.queryList(
        'select * from discrepancies where eventId = ? and save = 1 and `delete` = 0',
        arguments: <dynamic>[eventId],
        mapper: _discrepanciesMapper);
  }

  @override
  Future<List<Discrepancy>> getUnsavedDiscrepancies(String eventId) async {
    return _queryAdapter.queryList(
        'select * from discrepancies where eventId = ? and save = 0 and `delete` = 0',
        arguments: <dynamic>[eventId],
        mapper: _discrepanciesMapper);
  }

  @override
  Future<List<Discrepancy>> getUndeletedDiscrepancies(String eventId) async {
    return _queryAdapter.queryList(
        'select * from discrepancies where eventId = ? and `delete` = 1',
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
      : _queryAdapter = QueryAdapter(database),
        _eventDiscrepancyInsertionAdapter = InsertionAdapter(
            database,
            'events_discrepancies',
            (EventDiscrepancy item) => <String, dynamic>{
                  'id': item.id,
                  'eventId': item.eventId,
                  'discrepancyId': item.discrepancyId,
                  'confirmed': item.confirmed,
                  'save': item.save == null ? null : (item.save ? 1 : 0),
                  'delete': item.delete == null ? null : (item.delete ? 1 : 0)
                }),
        _eventDiscrepancyUpdateAdapter = UpdateAdapter(
            database,
            'events_discrepancies',
            ['id'],
            (EventDiscrepancy item) => <String, dynamic>{
                  'id': item.id,
                  'eventId': item.eventId,
                  'discrepancyId': item.discrepancyId,
                  'confirmed': item.confirmed,
                  'save': item.save == null ? null : (item.save ? 1 : 0),
                  'delete': item.delete == null ? null : (item.delete ? 1 : 0)
                }),
        _eventDiscrepancyDeletionAdapter = DeletionAdapter(
            database,
            'events_discrepancies',
            ['id'],
            (EventDiscrepancy item) => <String, dynamic>{
                  'id': item.id,
                  'eventId': item.eventId,
                  'discrepancyId': item.discrepancyId,
                  'confirmed': item.confirmed,
                  'save': item.save == null ? null : (item.save ? 1 : 0),
                  'delete': item.delete == null ? null : (item.delete ? 1 : 0)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _events_discrepanciesMapper = (Map<String, dynamic> row) =>
      EventDiscrepancy(
          id: row['id'] as int,
          eventId: row['eventId'] as String,
          discrepancyId: row['discrepancyId'] as String,
          confirmed: row['confirmed'] as int,
          save: row['save'] == null ? null : (row['save'] as int) != 0,
          delete: row['delete'] == null ? null : (row['delete'] as int) != 0);

  final InsertionAdapter<EventDiscrepancy> _eventDiscrepancyInsertionAdapter;

  final UpdateAdapter<EventDiscrepancy> _eventDiscrepancyUpdateAdapter;

  final DeletionAdapter<EventDiscrepancy> _eventDiscrepancyDeletionAdapter;

  @override
  Future<EventDiscrepancy> getEventDiscrepancy(
      String eventId, String playerId) async {
    return _queryAdapter.query(
        'select * from events_discrepancies where eventId = ? and playerId = ?',
        arguments: <dynamic>[eventId, playerId],
        mapper: _events_discrepanciesMapper);
  }

  @override
  Future<List<EventDiscrepancy>> getSavedEventDiscrepancies(
      String eventId) async {
    return _queryAdapter.queryList(
        'select * from events_discrepancies where eventId = ? and save = 1 and `delete` = 0',
        arguments: <dynamic>[eventId],
        mapper: _events_discrepanciesMapper);
  }

  @override
  Future<List<EventDiscrepancy>> getUnsavedEventDiscrepancies(
      String eventId) async {
    return _queryAdapter.queryList(
        'select * from events_discrepancies where eventId = ? and save = 0 and `delete` = 0',
        arguments: <dynamic>[eventId],
        mapper: _events_discrepanciesMapper);
  }

  @override
  Future<List<EventDiscrepancy>> getUndeletedEventDiscrepancies(
      String eventId) async {
    return _queryAdapter.queryList(
        'select * from events_discrepancies where eventId = ? and `delete` = 1',
        arguments: <dynamic>[eventId],
        mapper: _events_discrepanciesMapper);
  }

  @override
  Future<int> insertEventDiscrepancy(EventDiscrepancy eventDiscrepancy) {
    return _eventDiscrepancyInsertionAdapter.insertAndReturnId(
        eventDiscrepancy, OnConflictStrategy.replace);
  }

  @override
  Future<int> insertModel(EventDiscrepancy model) {
    return _eventDiscrepancyInsertionAdapter.insertAndReturnId(
        model, OnConflictStrategy.replace);
  }

  @override
  Future<int> updateModelDiscrepancy(EventDiscrepancy eventDiscrepancy) {
    return _eventDiscrepancyUpdateAdapter.updateAndReturnChangedRows(
        eventDiscrepancy, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateModel(EventDiscrepancy model) {
    return _eventDiscrepancyUpdateAdapter.updateAndReturnChangedRows(
        model, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteModelDiscrepancy(EventDiscrepancy eventDiscrepancy) {
    return _eventDiscrepancyDeletionAdapter
        .deleteAndReturnChangedRows(eventDiscrepancy);
  }

  @override
  Future<int> deleteModel(EventDiscrepancy model) {
    return _eventDiscrepancyDeletionAdapter.deleteAndReturnChangedRows(model);
  }
}
