import '../../models/mont_task_model.dart';
import '../../models/task_model.dart';
import '../../models/week_task_model.dart';
import '../../repositories/tasks/tasks_repository.dart';
import './task_service.dart';

class TaskServiceImpl implements TaskService {
  final TasksRepository _tasksRepository;

  TaskServiceImpl({required TasksRepository tasksRepository})
      : _tasksRepository = tasksRepository;

  @override
  Future<void> saveTask(String title, String description, DateTime date) =>
      _tasksRepository.saveTask(
        title,
        description,
        date,
      );

  @override
  Future<List<TaskModel>> getAll() {
    return _tasksRepository.findAll();
  }

  @override
  Future<List<TaskModel>> getMonth() async {
    final today = DateTime.now();
    final startDate = DateTime(today.year, today.month, 1, 0, 0, 0);
    final endDate = DateTime(today.year, today.month + 1, 0, 23, 59, 59);
    return _tasksRepository.findByPeriod(startDate, endDate);
  }

  @override
  Future<List<TaskModel>> getToday() {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month,now.day,0,0,0);
    final endOfDay = DateTime(now.year, now.month,now.day,23,59,59);
    return _tasksRepository.findByPeriod(startOfDay, endOfDay);
    // return _tasksRepository.findByPeriod(DateTime.now(), DateTime.now());
  }

  @override
  Future<List<TaskModel>> getTomorrow() {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    final startOfDay = DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 0, 0, 0);
    final endOfDay = DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 23, 59, 59);
    return _tasksRepository.findByPeriod(startOfDay, endOfDay);
    // var tomorrow = DateTime.now().add(const Duration(days: 1));
    // return _tasksRepository.findByPeriod(tomorrow, tomorrow);
  }

  @override
  Future<WeekTaskModel> getWeek() async {
    final today = DateTime.now();
    var startDate = DateTime(today.year, today.month, today.day, 0, 0, 0);
    DateTime endDate;

    if (startDate.weekday != DateTime.monday) {
      startDate = startDate.subtract(Duration(days: (startDate.weekday - 1)));
    }

    endDate = startDate.add(const Duration(days: 7));
    final tasks = await _tasksRepository.findByPeriod(startDate, endDate);
    return WeekTaskModel(startDate: startDate, endDate: endDate, tasks: tasks);
  }
}
