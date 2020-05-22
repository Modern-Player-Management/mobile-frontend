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
        ? join(await sqflite.getDatabasesPath(), name)
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

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    return sqflite.openDatabase(
      path,
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
            'CREATE TABLE IF NOT EXISTS `teams` (`id` TEXT, `player` TEXT, `name` TEXT, `description` TEXT, `image` TEXT, `managerId` TEXT, `created` TEXT, `save` INTEGER, `update` INTEGER, `delete` INTEGER, FOREIGN KEY (`managerId`) REFERENCES `players` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `players` (`id` TEXT, `username` TEXT, `email` TEXT, `created` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `teams_players` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `teamId` TEXT, `playerId` TEXT, `save` INTEGER, `delete` INTEGER, FOREIGN KEY (`teamId`) REFERENCES `teams` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`playerId`) REFERENCES `players` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `events` (`id` TEXT, `team` TEXT, `start` TEXT, `end` TEXT, `title` TEXT, `description` TEXT, `save` INTEGER, `update` INTEGER, `delete` INTEGER, FOREIGN KEY (`team`) REFERENCES `teams` (`id`) ON UPDATE NO ACTION ON DELETE CASCADE, PRIMARY KEY (`id`))');
        await database
            .execute('CREATE INDEX `index_teams_player` ON `teams` (`player`)');

        await callback?.onCreate?.call(database, version);
      },
    );
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
                  'save': item.save ? 1 : 0,
                  'update': item.update ? 1 : 0,
                  'delete': item.delete ? 1 : 0
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
                  'save': item.save ? 1 : 0,
                  'update': item.update ? 1 : 0,
                  'delete': item.delete ? 1 : 0
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
                  'save': item.save ? 1 : 0,
                  'update': item.update ? 1 : 0,
                  'delete': item.delete ? 1 : 0
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _teamsMapper = (Map<String, dynamic> row) => Team(
      id: row['id'] as String,
      name: row['name'] as String,
      description: row['description'] as String,
      player: row['player'] as String,
      managerId: row['managerId'] as String,
      save: (row['save'] as int) != 0,
      update: (row['update'] as int) != 0,
      delete: (row['delete'] as int) != 0);

  final InsertionAdapter<Team> _teamInsertionAdapter;

  final UpdateAdapter<Team> _teamUpdateAdapter;

  final DeletionAdapter<Team> _teamDeletionAdapter;

  @override
  Stream<List<Team>> getTeams(String player) {
    return _queryAdapter.queryListStream(
        'select * from teams where player = ? and `delete` = 0',
        arguments: <dynamic>[player],
        tableName: 'teams',
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
        'update teams set id = ? save = ? where id = ?',
        arguments: <dynamic>[oldId, newId, save]);
  }

  @override
  Future<int> insertTeam(Team team) {
    return _teamInsertionAdapter.insertAndReturnId(
        team, sqflite.ConflictAlgorithm.replace);
  }

  @override
  Future<int> updateTeam(Team team) {
    return _teamUpdateAdapter.updateAndReturnChangedRows(
        team, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<int> deleteTeam(Team team) {
    return _teamDeletionAdapter.deleteAndReturnChangedRows(team);
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
                  'created': item.created
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
                  'created': item.created
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
                  'created': item.created
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _playersMapper = (Map<String, dynamic> row) => Player(
      id: row['id'] as String,
      username: row['username'] as String,
      email: row['email'] as String);

  final InsertionAdapter<Player> _playerInsertionAdapter;

  final UpdateAdapter<Player> _playerUpdateAdapter;

  final DeletionAdapter<Player> _playerDeletionAdapter;

  @override
  Stream<List<Player>> getPlayers(List<String> ids) {
    final valueList1 = ids.map((value) => "'$value'").join(', ');
    return _queryAdapter.queryListStream(
        'select * from players where id in ($valueList1)',
        tableName: 'players',
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
  Future<int> insertPlayer(Player player) {
    return _playerInsertionAdapter.insertAndReturnId(
        player, sqflite.ConflictAlgorithm.replace);
  }

  @override
  Future<int> updatePlayer(Player player) {
    return _playerUpdateAdapter.updateAndReturnChangedRows(
        player, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<int> deletePlayer(Player player) {
    return _playerDeletionAdapter.deleteAndReturnChangedRows(player);
  }
}

class _$TeamPlayerDao extends TeamPlayerDao {
  _$TeamPlayerDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _teamPlayerInsertionAdapter = InsertionAdapter(
            database,
            'teams_players',
            (TeamPlayer item) => <String, dynamic>{
                  'id': item.id,
                  'teamId': item.teamId,
                  'playerId': item.playerId,
                  'save': item.save ? 1 : 0,
                  'delete': item.delete ? 1 : 0
                }),
        _teamPlayerUpdateAdapter = UpdateAdapter(
            database,
            'teams_players',
            ['id'],
            (TeamPlayer item) => <String, dynamic>{
                  'id': item.id,
                  'teamId': item.teamId,
                  'playerId': item.playerId,
                  'save': item.save ? 1 : 0,
                  'delete': item.delete ? 1 : 0
                }),
        _teamPlayerDeletionAdapter = DeletionAdapter(
            database,
            'teams_players',
            ['id'],
            (TeamPlayer item) => <String, dynamic>{
                  'id': item.id,
                  'teamId': item.teamId,
                  'playerId': item.playerId,
                  'save': item.save ? 1 : 0,
                  'delete': item.delete ? 1 : 0
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _teams_playersMapper = (Map<String, dynamic> row) => TeamPlayer(
      id: row['id'] as int,
      teamId: row['teamId'] as String,
      playerId: row['playerId'] as String,
      save: (row['save'] as int) != 0,
      delete: (row['delete'] as int) != 0);

  final InsertionAdapter<TeamPlayer> _teamPlayerInsertionAdapter;

  final UpdateAdapter<TeamPlayer> _teamPlayerUpdateAdapter;

  final DeletionAdapter<TeamPlayer> _teamPlayerDeletionAdapter;

  @override
  Future<List<TeamPlayer>> getTeamPlayers(String teamId) async {
    return _queryAdapter.queryList(
        'select * from teams_players where teamId = ? and `delete` = 0',
        arguments: <dynamic>[teamId],
        mapper: _teams_playersMapper);
  }

  @override
  Future<List<TeamPlayer>> getSavedTeamPlayers(String teamId) async {
    return _queryAdapter.queryList(
        'select * from teams_players where teamId = ? and save = 1 and `delete` = 0',
        arguments: <dynamic>[teamId],
        mapper: _teams_playersMapper);
  }

  @override
  Future<List<TeamPlayer>> getUnsavedTeamPlayers(String teamId) async {
    return _queryAdapter.queryList(
        'select * from teams_players where teamId = ? and save = 0 and `delete` = 0',
        arguments: <dynamic>[teamId],
        mapper: _teams_playersMapper);
  }

  @override
  Future<List<TeamPlayer>> getUndeletedTeamPlayers(String teamId) async {
    return _queryAdapter.queryList(
        'select * from teams_players where teamId = ? and `delete` = 1',
        arguments: <dynamic>[teamId],
        mapper: _teams_playersMapper);
  }

  @override
  Future<TeamPlayer> getTeamPlayer(String teamId, String playerId) async {
    return _queryAdapter.query(
        'select * from teams_players where teamId = ? and playerId = ?',
        arguments: <dynamic>[teamId, playerId],
        mapper: _teams_playersMapper);
  }

  @override
  Future<int> insertTeamPlayer(TeamPlayer teamPlayer) {
    return _teamPlayerInsertionAdapter.insertAndReturnId(
        teamPlayer, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<int> updateTeamPlayer(TeamPlayer teamPlayer) {
    return _teamPlayerUpdateAdapter.updateAndReturnChangedRows(
        teamPlayer, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<int> deleteTeamPlayer(TeamPlayer teamPlayer) {
    return _teamPlayerDeletionAdapter.deleteAndReturnChangedRows(teamPlayer);
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
                  'title': item.title,
                  'description': item.description,
                  'save': item.save ? 1 : 0,
                  'update': item.update ? 1 : 0,
                  'delete': item.delete ? 1 : 0
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
                  'title': item.title,
                  'description': item.description,
                  'save': item.save ? 1 : 0,
                  'update': item.update ? 1 : 0,
                  'delete': item.delete ? 1 : 0
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
                  'title': item.title,
                  'description': item.description,
                  'save': item.save ? 1 : 0,
                  'update': item.update ? 1 : 0,
                  'delete': item.delete ? 1 : 0
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
      title: row['title'] as String,
      description: row['description'] as String,
      save: (row['save'] as int) != 0,
      update: (row['update'] as int) != 0,
      delete: (row['delete'] as int) != 0);

  final InsertionAdapter<Event> _eventInsertionAdapter;

  final UpdateAdapter<Event> _eventUpdateAdapter;

  final DeletionAdapter<Event> _eventDeletionAdapter;

  @override
  Stream<List<Event>> getEvents(String team) {
    return _queryAdapter.queryListStream(
        'select * from events where team = ? and `delete` = 0',
        arguments: <dynamic>[team],
        tableName: 'events',
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
  Future<int> insertEvent(Event event) {
    return _eventInsertionAdapter.insertAndReturnId(
        event, sqflite.ConflictAlgorithm.replace);
  }

  @override
  Future<int> updateEvent(Event event) {
    return _eventUpdateAdapter.updateAndReturnChangedRows(
        event, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<int> deleteEvent(Event event) {
    return _eventDeletionAdapter.deleteAndReturnChangedRows(event);
  }
}
