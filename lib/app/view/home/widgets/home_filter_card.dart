import 'package:flutter/material.dart';
import '../../../core/ui/app_theme_extensions.dart';

class HomeFilterCard extends StatelessWidget {
  const HomeFilterCard({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(20),
        constraints: const BoxConstraints(
          minHeight: 120,
          maxWidth: 150,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
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
        child: Column(
          spacing: 4,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '10 Tasks',
              style: context.titleText.copyWith(
                fontSize: 10,
                color: context.primaryColor,
              ),
            ),
            Text('Hoje', style: context.titleText),
            LinearProgressIndicator(
              value: 0.3,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation(context.primaryColor),
            ),
          ],
        ));
  }
}
