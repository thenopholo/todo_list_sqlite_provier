import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/ui/app_theme_extensions.dart';
import '../../../models/task_filter_enum.dart';
import '../../../models/task_model.dart';
import '../home_controller.dart';
import 'task.dart';

class HomeTask extends StatelessWidget {
  const HomeTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          const SizedBox(height: 20),
          Selector<HomeController, String>(
            selector: (context, controller) => controller.selectedFilter.period,
            builder: (context, period, child) {
              return Text(
                'TASK\'S $period',
                style: context.titleText,
              );
            },
          ),
          Column(
            children: context
                .select<HomeController, List<TaskModel>>(
                    (controller) => controller.filteredTasks)
                .map(
                  (task) => Dismissible(
                    key: Key(task.id.toString()),
                    direction: DismissDirection.horizontal,
                    background: Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    secondaryBackground: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    onDismissed: (direction) {
                      if (direction == DismissDirection.endToStart) {
                        context.read<HomeController>().deleteTask(task);
                      } else {
                        context.read<HomeController>().deleteTask(task);
                      }
                    },
                    child: Task(model: task),
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}
