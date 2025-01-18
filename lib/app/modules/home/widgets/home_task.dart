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
                .map((t) => Task(model: t,))
                .toList(),
          )
        ],
      ),
    );
  }
}
