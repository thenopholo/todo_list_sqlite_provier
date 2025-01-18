import 'package:flutter/material.dart';

import '../../core/notifier/default_change_notifier.dart';
import '../../models/mont_task_model.dart';
import '../../models/task_filter_enum.dart';
import '../../models/task_model.dart';
import '../../models/total_task_model.dart';
import '../../models/week_task_model.dart';
import '../../services/task/task_service.dart';

class HomeController extends DefaultChangeNotifier {
  final TaskService _taskService;
  var selectedFilter = TaskFilterEnum.today;
  TotalTaskModel? todayTotalTasks;
  TotalTaskModel? tomorrowTotalTasks;
  TotalTaskModel? weekTotalTasks;
  List<TaskModel> allTasks = [];
  List<TaskModel> filteredTasks = [];
  DateTime? initialDayOfWeek;
  DateTime? selectedDay;

  HomeController({required TaskService taskService})
      : _taskService = taskService;

  Future<void> loadAllTasks() async {
    final allTotalTasks = await Future.wait([
      _taskService.getToday(),
      _taskService.getTomorrow(),
      _taskService.getWeek(),
      // _taskService.getMonth(),
      // _taskService.getAll(),
    ]);

    final todayTasks = allTotalTasks[0] as List<TaskModel>;
    final tomorrowTasks = allTotalTasks[1] as List<TaskModel>;
    final weekTasks = allTotalTasks[2] as WeekTaskModel;
    // final monthTasks = allTotalTasks[3] as MonthTaskModel;
    // final all = allTotalTasks[4] as List<TaskModel>;

    todayTotalTasks = TotalTaskModel(
      totalTasks: todayTasks.length,
      totalTasksDone: todayTasks.where((task) => task.isDone).length,
    );
    tomorrowTotalTasks = TotalTaskModel(
      totalTasks: tomorrowTasks.length,
      totalTasksDone: tomorrowTasks.where((task) => task.isDone).length,
    );
    weekTotalTasks = TotalTaskModel(
      totalTasks: weekTasks.tasks.length,
      totalTasksDone: weekTasks.tasks.where((task) => task.isDone).length,
    );
    // monthTotalTasks = TotalTaskModel(
    //   totalTasks: monthTasks.tasks.length,
    //   totalTasksDone: monthTasks.tasks.where((task) => task.isDone).length,
    // );
    // allTasks = TotalTaskModel(
    //   totalTasks: all.length,
    //   totalTasksDone: all.where((task) => task.isDone).length,
    // );

    notifyListeners();
  }

  Future<void> findTasks({required TaskFilterEnum filter}) async {
    selectedFilter = filter;
    showLoading();
    notifyListeners();
    List<TaskModel> tasks;

    switch (filter) {
      case TaskFilterEnum.today:
        tasks = await _taskService.getToday();
        break;
      case TaskFilterEnum.tomorrow:
        tasks = await _taskService.getTomorrow();
        break;
      case TaskFilterEnum.week:
        final weekModel = await _taskService.getWeek();
        initialDayOfWeek = weekModel.startDate;
        tasks = weekModel.tasks;
        break;
    }

    filteredTasks = tasks;
    allTasks = tasks;

    if (filter == TaskFilterEnum.week) {
      if(selectedDay != null) {
        filterByDay(selectedDay!);
      } else if (initialDayOfWeek != null) {
        filterByDay(initialDayOfWeek!);
      }
    } else {
      selectedDay = null;
    }

    hideLoading();
    notifyListeners();
  }

  Future<void> filterByDay(DateTime day) async {
    selectedDay = day;
    filteredTasks = allTasks.where((task) {
      return task.date == day;
    }).toList();
    notifyListeners();
  }

  Future<void> refreshPage() async {
    await findTasks(filter: selectedFilter);
    await loadAllTasks();
    notifyListeners();
  }
}
