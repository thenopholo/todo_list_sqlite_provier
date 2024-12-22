import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todolist/app/app_widget.dart';
import 'package:provider/provider.dart';

import 'core/database/sqlite_connection_factory.dart';
import 'repositories/user_repository.dart';
import 'repositories/user_repository_impl.dart';
import 'services/user_service.dart';
import 'services/user_service_impl.dart';

class AppModule extends StatelessWidget {
  const AppModule({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => FirebaseAuth.instance),
        Provider(
          create: (_) => SqliteConnectionFactory(),
          lazy: false,
        ),
        Provider<UserRepository>(
          create: (context) => UserRepositoryImpl(auth: context.read()),
        ),
        Provider<UserService>(
          create: (context) => UserServiceImpl(userRepository: context.read()),
        ),
      ],
      child: AppWidget(),
    );
  }
}
