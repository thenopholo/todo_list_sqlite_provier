import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/ui/app_theme_extensions.dart';
import '../../../models/task_filter_enum.dart';
import '../../../models/total_task_model.dart';
import '../home_controller.dart';
import 'home_filter_card.dart';

class HomeFilters extends StatelessWidget {
  const HomeFilters({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Text(
          'FILTROS',
          style: context.titleText,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            spacing: 8,
            children: [
              HomeFilterCard(
                label: 'Hoje',
                taskFilterType: TaskFilterEnum.today,
                totalTasks: context.select<HomeController, TotalTaskModel?>(
                    (controller) => controller.todayTotalTasks),
                isSelected: context.select<HomeController, TaskFilterEnum>(
                        (value) => value.selectedFilter) ==
                    TaskFilterEnum.today,
              ),
              HomeFilterCard(
                label: 'Amanhã',
                taskFilterType: TaskFilterEnum.tomorrow,
                totalTasks: context.select<HomeController, TotalTaskModel?>(
                    (controller) => controller.tomorrowTotalTasks),
                isSelected: context.select<HomeController, TaskFilterEnum>(
                        (value) => value.selectedFilter) ==
                    TaskFilterEnum.tomorrow,
              ),
              HomeFilterCard(
                label: 'Semana',
                taskFilterType: TaskFilterEnum.week,
                totalTasks: context.select<HomeController, TotalTaskModel?>(
                    (controller) => controller.weekTotalTasks),
                isSelected: context.select<HomeController, TaskFilterEnum>(
                        (value) => value.selectedFilter) ==
                    TaskFilterEnum.week,
              ),
              // HomeFilterCard(
              //   label: 'Mês',
              //   taskFilterType: TaskFilterEnum.month,
              //   totalTasks: context.select<HomeController, TotalTaskModel?>(
              //       (controller) => controller.monthTotalTasks),
              //   isSelected: context.select<HomeController, TaskFilterEnum>(
              //           (value) => value.selectedFilter) ==
              //       TaskFilterEnum.month,
              // ),
              // HomeFilterCard(
              //   label: 'Todas',
              //   taskFilterType: TaskFilterEnum.all,
              //   totalTasks: context.select<HomeController, TotalTaskModel?>(
              //       (controller) => controller.allTasks),
              //   isSelected: context.select<HomeController, TaskFilterEnum>(
              //           (value) => value.selectedFilter) ==
              //       TaskFilterEnum.all,
              // ),
            ],
          ),
        ),
      ],
    );
  }
}
