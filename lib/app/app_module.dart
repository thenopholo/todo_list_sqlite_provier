import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_widget.dart';
import 'core/database/sqlite_connection_factory.dart';
import 'repositories/user_repository.dart';
import 'repositories/user_repository_impl.dart';
import 'services/user/user_service.dart';
import 'services/user/user_service_impl.dart';
import 'core/auth/app_auth_provider.dart';  

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
        ChangeNotifierProvider(
          create: (context) => AppAuthProvider(
            auth: context.read(),
            userService: context.read(),
          )..loadListener(),
          lazy: false,
        ),
      ],
      child: const AppWidget(),
    );
  }
}
