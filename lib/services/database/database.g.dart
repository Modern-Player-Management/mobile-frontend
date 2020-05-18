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
            'CREATE TABLE IF NOT EXISTS `teams` (`id` TEXT, `user` TEXT, `name` TEXT, `save` INTEGER, `update` INTEGER, `delete` INTEGER, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `events` (`id` TEXT, `team` TEXT, `start` TEXT, `end` TEXT, `title` TEXT, `description` TEXT, `save` INTEGER, `update` INTEGER, `delete` INTEGER, FOREIGN KEY (`team`) REFERENCES `teams` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`id`))');
        await database
            .execute('CREATE INDEX `index_teams_user` ON `teams` (`user`)');

        await callback?.onCreate?.call(database, version);
      },
    );
  }

  @override
  TeamDao get teamDao {
    return _teamDaoInstance ??= _$TeamDao(database, changeListener);
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
                  'user': item.user,
                  'name': item.name,
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
                  'user': item.user,
                  'name': item.name,
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
                  'user': item.user,
                  'name': item.name,
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
      user: row['user'] as String,
      name: row['name'] as String,
      save: (row['save'] as int) != 0,
      update: (row['update'] as int) != 0,
      delete: (row['delete'] as int) != 0);

  final InsertionAdapter<Team> _teamInsertionAdapter;

  final UpdateAdapter<Team> _teamUpdateAdapter;

  final DeletionAdapter<Team> _teamDeletionAdapter;

  @override
  Stream<List<Team>> getTeams(String user) {
    return _queryAdapter.queryListStream(
        'select * from teams where user = ? and `delete` = 0',
        arguments: <dynamic>[user],
        tableName: 'teams',
        mapper: _teamsMapper);
  }

  @override
  Future<List<Team>> getSavedTeams(String user) async {
    return _queryAdapter.queryList(
        'select * from teams where user = ? and save = 1 and `delete` = 0',
        arguments: <dynamic>[user],
        mapper: _teamsMapper);
  }

  @override
  Future<List<Team>> getUnsavedTeams(String user) async {
    return _queryAdapter.queryList(
        'select * from teams where user = ? and save = 0 and `delete` = 0',
        arguments: <dynamic>[user],
        mapper: _teamsMapper);
  }

  @override
  Future<List<Team>> getUndeletedTeams(String user) async {
    return _queryAdapter.queryList(
        'select * from teams where user = ? and `delete` = 1',
        arguments: <dynamic>[user],
        mapper: _teamsMapper);
  }

  @override
  Future<void> insertTeam(Team unit) async {
    await _teamInsertionAdapter.insert(unit, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<void> updateTeam(Team unit) async {
    await _teamUpdateAdapter.update(unit, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<void> deleteTeam(Team unit) async {
    await _teamDeletionAdapter.delete(unit);
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
  Stream<List<Event>> getEvents(String user) {
    return _queryAdapter.queryListStream(
        'select * from events where user = ? and `delete` = 0',
        arguments: <dynamic>[user],
        tableName: 'events',
        mapper: _eventsMapper);
  }

  @override
  Future<List<Event>> getSavedEvents(String user) async {
    return _queryAdapter.queryList(
        'select * from events where user = ? and save = 1 and `delete` = 0',
        arguments: <dynamic>[user],
        mapper: _eventsMapper);
  }

  @override
  Future<List<Event>> getUnsavedEvents(String user) async {
    return _queryAdapter.queryList(
        'select * from events where user = ? and save = 0 and `delete` = 0',
        arguments: <dynamic>[user],
        mapper: _eventsMapper);
  }

  @override
  Future<List<Event>> getUndeletedEvents(String user) async {
    return _queryAdapter.queryList(
        'select * from events where user = ? and `delete` = 1',
        arguments: <dynamic>[user],
        mapper: _eventsMapper);
  }

  @override
  Future<void> insertEvent(Event unit) async {
    await _eventInsertionAdapter.insert(unit, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<void> updateEvent(Event unit) async {
    await _eventUpdateAdapter.update(unit, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<void> deleteEvent(Event unit) async {
    await _eventDeletionAdapter.delete(unit);
  }
}
