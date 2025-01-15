import 'package:flutter/material.dart';

import '../../../core/ui/app_theme_extensions.dart';

class Task extends StatelessWidget {
  const Task({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: context.primaryColor,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(45),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: ListTile(
          contentPadding: const EdgeInsets.all(8.0),
          leading: Checkbox(
            onChanged: (value) {},
            value: true,
          ),
          title: const Text(
            'Descrição da task',
            style: TextStyle(
              decoration: true ? TextDecoration.lineThrough : null,
            ),
          ),
          subtitle: const Text(
            '15/01/25',
            style: TextStyle(
              decoration: true ? TextDecoration.lineThrough : null,
            ),
          ),
        ),
      ),
    );
  }
}
