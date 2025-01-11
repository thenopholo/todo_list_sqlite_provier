import '../../core/modules/todo_list_modules.dart';
import 'home_page.dart';

class HomeModule extends TodoListModules {
  HomeModule()
      : super(
          // bindings: [],
          routes: {
            '/home': (context) => const HomePage(),
          },
        );
}
