class TaskModel {
  final int id;
  final String title;
  final String description;
  final DateTime date;
  final bool isDone;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.isDone,
  });

  factory TaskModel.loadFromDB(Map<String, dynamic> task) {
    return TaskModel(
      id: task['id'],
      title: task['title'],
      description: task['description'],
      date: DateTime.parse(task['date_time']),
      isDone: task['done'] == 1,
    );
  }
}
