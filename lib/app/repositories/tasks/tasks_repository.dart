abstract interface class TasksRepository {
  Future<void> saveTask(String title, String description, DateTime date);
}