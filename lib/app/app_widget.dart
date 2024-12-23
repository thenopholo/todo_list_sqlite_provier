import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todolist/app/view/splash/spalsh_page.dart';


import 'core/database/sqlite_adm_connection.dart';
import 'core/ui/todo_list_ui_config.dart';
import 'view/auth/auth_module.dart';


class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  final sqliteAdmConnection = SqliteAdmConnection();

  @override
  void initState() {
    super.initState();
    FirebaseAuth auth = FirebaseAuth.instance;
    WidgetsBinding.instance?.addObserver(sqliteAdmConnection);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(sqliteAdmConnection);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter TodoList',
      theme: TodoListUiConfig.theme,
      initialRoute: '/login',
      routes: {
        ...AuthModule().routes,
      },
      home: const SpalshPage(),
    );
  }
}
