abstract interface class TaskService {
  Future<void> saveTask(String title, String description, DateTime date);
}