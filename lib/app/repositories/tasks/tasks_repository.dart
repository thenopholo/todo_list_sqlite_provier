import '../../models/task_model.dart';

abstract interface class TasksRepository {
  Future<void> saveTask(String title, String description, DateTime date);
  Future<List<TaskModel>>findByPeriod(DateTime start, DateTime end);
  Future<List<TaskModel>>findAll();
  Future<void> checkOrUncheckTask(TaskModel task);
}