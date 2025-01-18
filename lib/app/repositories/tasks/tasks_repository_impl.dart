import 'dart:developer';

import '../../core/database/sqlite_connection_factory.dart';
import '../../models/task_model.dart';
import './tasks_repository.dart';

class TasksRepositoryImpl implements TasksRepository {
  final SqliteConnectionFactory _connectionFactory;

  TasksRepositoryImpl({required SqliteConnectionFactory connectionFactory})
      : _connectionFactory = connectionFactory;

  @override
  Future<void> saveTask(String title, String description, DateTime date) async {
    final conn = await _connectionFactory.openConnection();
    await conn.insert('todo', {
      'id': null,
      'title': title,
      'description': description,
      'date_time': date.toIso8601String(),
      'done': 0,
    });
  }

  @override
  Future<List<TaskModel>> findByPeriod(DateTime start, DateTime end) async {
    try {
      final startDate = DateTime(start.year, start.month, start.day, 0, 0, 0);
      final endDate = DateTime(end.year, end.month, end.day, 23, 59, 59);

      final conn = await _connectionFactory.openConnection();

      final result = await conn.rawQuery('''
  SELECT * FROM todo
  WHERE date_time BETWEEN ? AND ?
  ORDER BY date_time
''', [
        startDate.toIso8601String(),
        endDate.toIso8601String(),
      ]);

      return result.map((e) => TaskModel.loadFromDB(e)).toList();
    } catch (e, s) {
      log('Erro: $e, Stack: $s');
      return [];
    }
  }

  @override
  Future<List<TaskModel>> findAll() async {
    final conn = await _connectionFactory.openConnection();
    final result = await conn.rawQuery(
      '''
    SELECT *
    FROM todo
    WHERE done = 0
    ORDER BY date_time
    ''',
    );

    return result.map((e) => TaskModel.loadFromDB(e)).toList();
  }

  @override
  Future<void> checkOrUncheckTask(TaskModel task) async {
    final conn = await _connectionFactory.openConnection();
    final done = task.isDone ? 1 : 0;

    await conn.rawUpdate('''
      UPDATE todo
      SET done = ?
      WHERE id = ?
''', [done, task.id]);
  }
}
