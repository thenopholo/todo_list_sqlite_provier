
import 'package:provider/provider.dart';

import '../../core/modules/todo_list_modules.dart';
import 'login/login_controller.dart';
import 'login/login_page.dart';

class AuthModule extends TodoListModules {
  AuthModule() : super(
    bindings: [
      ChangeNotifierProvider(
        create: (_) => LoginController(),
      ),
    ],
    routes: {
      '/login': (contex) => const LoginPage(),
          
    },
  );


  
}