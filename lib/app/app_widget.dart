import 'package:flutter/material.dart';
import 'package:flutter_todolist/app/view/splash/spalsh_page.dart';
import 'package:provider/provider.dart';

import 'core/database/sqlite_adm_connection.dart';
import 'view/auth/auth_module.dart';
import 'view/auth/login/login_controller.dart';
import 'view/auth/login/login_page.dart';

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
      initialRoute: '/login',
      routes: {
        ...AuthModule().routes,
      },
      home: const SpalshPage(),
    );
  }
}
