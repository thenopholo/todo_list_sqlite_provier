import 'package:flutter/material.dart';

import '../ui/app_theme_extensions.dart';

class TodoListLogo extends StatelessWidget {
  const TodoListLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/logo.png',
          height: 200,
        ),
        Text(
          'TODO List',
          style: context.textTheme.headlineLarge,
        ),
      ],
    );
  }
}
