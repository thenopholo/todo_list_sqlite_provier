import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/ui/app_theme_extensions.dart';
import '../../../models/task_filter_enum.dart';
import '../home_controller.dart';

class HomeWeekFilter extends StatelessWidget {
  const HomeWeekFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: context.select<HomeController, bool>(
        (controller) => controller.selectedFilter == TaskFilterEnum.week,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 4,
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            'DIAS DA SEMANA',
            style: context.titleText,
          ),
          Container(
            height: 95,
            child: Selector<HomeController, DateTime>(
              selector: (context, controller) =>
                  controller.initialDayOfWeek ?? DateTime.now(),
              builder: (_, value, __) {
                return DatePicker(
                  value,
                  locale: 'pt_BR',
                  initialSelectedDate: value,
                  selectionColor: context.primaryColor,
                  selectedTextColor: Colors.white,
                  daysCount: 7,
                  monthTextStyle: const TextStyle(fontSize: 8),
                  dayTextStyle: const TextStyle(fontSize: 13),
                  dateTextStyle: const TextStyle(fontSize: 23),
                  onDateChange: (date) {
                    context.read<HomeController>().filterByDay(date);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
