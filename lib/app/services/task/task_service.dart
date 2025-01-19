import '../../models/task_model.dart';
import '../../models/week_task_model.dart';

abstract interface class TaskService {
  Future<void> saveTask(String title, String description, DateTime date);
  Future<List<TaskModel>> getToday();
  Future<List<TaskModel>> getTomorrow();
  Future<WeekTaskModel> getWeek();
  Future<void> checkOrUncheckTask(TaskModel task);
  Future<void> deleteTask(TaskModel task);
}
