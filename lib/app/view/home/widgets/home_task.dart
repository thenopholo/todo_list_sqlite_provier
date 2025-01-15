import 'package:flutter/material.dart';

import '../../../core/ui/app_theme_extensions.dart';
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
          Text(
            'TASK\'S DE HOJE',
            style: context.titleText.copyWith(fontSize: 18),
          ),
          const Column(
            children: [
              Task(),
              Task(),
              Task(),
              Task(),
              Task(),
              Task(),
              Task(),
              Task(),
              Task(),
            ],
          )
        ],
      ),
    );
  }
}
