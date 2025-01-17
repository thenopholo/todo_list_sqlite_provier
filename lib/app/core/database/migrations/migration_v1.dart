import 'package:sqflite_common/sqlite_api.dart';

import 'migration.dart';

class MigrationV1 implements Migration {
  @override
  void create(Batch batch) {
    batch.execute('''
        create table todo(
        id Integer primary key autoincrement,
        title varchar(500) null,
        description varchar(500) null,
        date_time datetime,
        done integer
        )
  ''');
  }

  @override
  void update(Batch batch) {}
}
