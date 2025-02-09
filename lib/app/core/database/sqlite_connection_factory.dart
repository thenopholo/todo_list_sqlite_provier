import 'package:path/path.dart';
import 'package:synchronized/synchronized.dart';
import 'package:sqflite/sqflite.dart';

import 'sqlite_migration_factory.dart';

class SqliteConnectionFactory {
  static const _VERSION = 1;
  static const _DATABASE_NAME = 'TODO_LIST_PROVIDER';
  static SqliteConnectionFactory? _instance;
  Database? _db;
  final _lock = Lock();

  SqliteConnectionFactory._();

  factory SqliteConnectionFactory() {
    
    _instance ??= SqliteConnectionFactory._();
    return _instance!;
  }

  Future<Database> openConnection() async {
    var databasePath = await getDatabasesPath();
    var finalDatabasePath = join(databasePath, _DATABASE_NAME);
    if (_db == null) {
      await _lock.synchronized(
        () async {
          if (_db == null) {
          try {
            print('Abrindo banco de dados em: $finalDatabasePath');
            _db = await openDatabase(
              finalDatabasePath,
              version: _VERSION,
              onConfigure: _onConfigure,
              onCreate: _onCreate,
              onUpgrade: _onUpgrade,
              onDowngrade: _onDowngrade,
            );
            print('Banco de dados aberto com sucesso.');
          } catch (e, stack) {
            print('Erro ao abrir banco de dados: $e');
            print(stack);
            rethrow;
          }
        }
        },
      );
    }

    return _db!;
  }

  void closeConnection() {
    _db?.close();
    _db = null;
  }

  Future<void> _onConfigure(Database _db) async {
    await _db.execute('PRAGMA foreign_keys = ON');
  }

  Future<void> _onCreate(Database _db, int version) async {
    final batch = _db.batch();
    final migrations = SqliteMigrationFactory().getCreateMigration();
    for (var migration in migrations) {
      migration.create(batch);
    }

    batch.commit();
  }

  Future<void> _onUpgrade(Database _db, int oldVersion, int version) async {
    final batch = _db.batch();
    final migrations = SqliteMigrationFactory().getUpgradeMigration(oldVersion);
    for (var migration in migrations) {
      migration.update(batch);
    }

    batch.commit();
  }

  Future<void> _onDowngrade(Database _db, int oldVersion, int version) async {}
}
