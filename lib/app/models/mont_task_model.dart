
import 'task_model.dart';

class MonthTaskModel {
  final DateTime startDate;
  final DateTime endDate;
  final List<TaskModel> tasks;

  MonthTaskModel({
    required this.startDate,
    required this.endDate,
    required this.tasks,
  });
}