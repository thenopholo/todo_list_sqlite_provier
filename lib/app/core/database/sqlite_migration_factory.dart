import 'dart:developer';

import 'migrations/migration.dart';
import 'migrations/migration_v1.dart';
import 'migrations/migration_v2.dart';
import 'migrations/migration_v3.dart';

class SqliteMigrationFactory {
  List<Migration> getCreateMigration() {
  try {
    return [
      MigrationV1(),
      MigrationV2(),
      MigrationV3(),
    ];
  } catch (e, s) {
    log('Erro ao obter migrações: $e, Stack: $s');
    return [];
  }
}




  List<Migration> getUpgradeMigration(int version) {
    final migrations = <Migration>[];

    if(version == 1) {
      migrations.add(MigrationV2());
      migrations.add(MigrationV3());
    }

    if(version == 2) {
      migrations.add(MigrationV3());
    }

    return migrations;
  }
}
