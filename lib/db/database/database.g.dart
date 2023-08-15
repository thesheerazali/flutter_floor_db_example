// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
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

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

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
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
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
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ContactDao? _contactDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
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
            'CREATE TABLE IF NOT EXISTS `Contacts` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `phone` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ContactDao get contactDao {
    return _contactDaoInstance ??= _$ContactDao(database, changeListener);
  }
}

class _$ContactDao extends ContactDao {
  _$ContactDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _contactsInsertionAdapter = InsertionAdapter(
            database,
            'Contacts',
            (Contacts item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'phone': item.phone
                }),
        _contactsUpdateAdapter = UpdateAdapter(
            database,
            'Contacts',
            ['id'],
            (Contacts item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'phone': item.phone
                }),
        _contactsDeletionAdapter = DeletionAdapter(
            database,
            'Contacts',
            ['id'],
            (Contacts item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'phone': item.phone
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Contacts> _contactsInsertionAdapter;

  final UpdateAdapter<Contacts> _contactsUpdateAdapter;

  final DeletionAdapter<Contacts> _contactsDeletionAdapter;

  @override
  Future<List<Contacts>> getAll() async {
    return _queryAdapter.queryList('SELECT * FROM contacts',
        mapper: (Map<String, Object?> row) => Contacts(
            row['id'] as int?, row['name'] as String, row['phone'] as String));
  }

  @override
  Future<Contacts?> findbyid(int id) async {
    return _queryAdapter.query('SELECT * FROM contacts WHERE id= ?1',
        mapper: (Map<String, Object?> row) => Contacts(
            row['id'] as int?, row['name'] as String, row['phone'] as String),
        arguments: [id]);
  }

  @override
  Future<Contacts?> findbyname(String name) async {
    return _queryAdapter.query(
        'SELECT * FROM contacts WHERE name LIKE \'%?1%\'',
        mapper: (Map<String, Object?> row) => Contacts(
            row['id'] as int?, row['name'] as String, row['phone'] as String),
        arguments: [name]);
  }

  @override
  Future<Contacts?> findbyphone(String phone) async {
    return _queryAdapter.query(
        'SELECT * FROM contacts WHERE phone LIKE \'%?1%\'',
        mapper: (Map<String, Object?> row) => Contacts(
            row['id'] as int?, row['name'] as String, row['phone'] as String),
        arguments: [phone]);
  }

  @override
  Future<void> addContacts(Contacts contacts) async {
    await _contactsInsertionAdapter.insert(contacts, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateContacts(Contacts contacts) async {
    await _contactsUpdateAdapter.update(contacts, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteContacts(Contacts contacts) async {
    await _contactsDeletionAdapter.delete(contacts);
  }
}
