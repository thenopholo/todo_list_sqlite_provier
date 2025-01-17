import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/ui/app_theme_extensions.dart';
import '../task_create_controller.dart';

class TaskCalendarButton extends StatelessWidget {
  final dateFormat = DateFormat('dd/MM/yyyy');

  TaskCalendarButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final now = DateTime.now();
        final firstDate = now.subtract(const Duration(days: 365 * 2));
        final lastDate = now.add(const Duration(days: 365 * 8));

        final DateTime? selectedDate = await showDatePicker(
          context: context,
          initialDate: now,
          firstDate: firstDate,
          lastDate: lastDate,
        );

        context.read<TaskCreateController>().selectedDate = selectedDate;
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: context.primaryColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(2, 5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [
              Icon(
                CupertinoIcons.calendar,
                color: context.primaryColor,
              ),
              Selector<TaskCreateController, DateTime?>(
                selector: (context, controller) => controller.selectedDate,
                builder: (context, selectedDate, child) {
                  if (selectedDate != null) {
                    return Text(
                      dateFormat.format(selectedDate),
                      style: TextStyle(
                        color: context.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    );
                  } else {
                    return Text(
                      'Selecione uma data',
                      style: TextStyle(
                        color: context.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
