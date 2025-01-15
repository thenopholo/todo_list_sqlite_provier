import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';

import '../../../core/ui/app_theme_extensions.dart';

class HomeWeekFilter extends StatelessWidget {
  const HomeWeekFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
          child: DatePicker(
            DateTime.now(),
            locale: 'pt_BR',
            initialSelectedDate: DateTime.now(),
            selectionColor: context.primaryColor,
            selectedTextColor: Colors.white,
            daysCount: 7,
            monthTextStyle: const TextStyle(fontSize: 8),
            dayTextStyle: const TextStyle(fontSize: 13),
            dateTextStyle: const TextStyle(fontSize: 23),
          ),
        )
      ],
    );
  }
}
