import 'package:sqflite_common/sqlite_api.dart';

import 'migration.dart';

  @override
class MigrationV2 implements Migration {
  void create(Batch batch) {
    batch.execute('creaete table teste(id integer)');
  }

  @override
  void update(Batch batch) {
    batch.execute('creaete table teste(id integer)');
  }

}