import 'package:flutter/material.dart';

import '../../core/widget/todo_list_logo.dart';

class SpalshPage extends StatelessWidget {
  const SpalshPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: TodoListLogo(),
      ),
    );
  }
}