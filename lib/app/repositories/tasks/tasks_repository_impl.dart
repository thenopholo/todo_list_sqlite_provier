import '../../core/database/sqlite_connection_factory.dart';
import './tasks_repository.dart';

class TasksRepositoryImpl implements TasksRepository {
  final SqliteConnectionFactory _connectionFactory;

  TasksRepositoryImpl({required SqliteConnectionFactory connectionFactory})
      : _connectionFactory = connectionFactory;

  @override
  Future<void> saveTask(String title, String description, DateTime date) async{
    final conn = await _connectionFactory.openConnection();
    await conn.insert('todo', {
      'id': null,
      'title': title,
      'description': description,
      'date_time': date.toIso8601String(),
      'done': 0,
    });
  }
}
