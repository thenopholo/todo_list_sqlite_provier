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
}
