import 'package:provider/provider.dart';

import '../../core/modules/todo_list_modules.dart';
import '../../repositories/tasks/tasks_repository.dart';
import '../../repositories/tasks/tasks_repository_impl.dart';
import '../../services/task/task_service.dart';
import '../../services/task/task_service_impl.dart';
import 'home_controller.dart';
import 'home_page.dart';

class HomeModule extends TodoListModules {
  HomeModule()
      : super(
          bindings: [
            Provider<TasksRepository>(
                create: (context) =>
                    TasksRepositoryImpl(connectionFactory: context.read())),
            Provider<TaskService>(
                create: (context) =>
                    TaskServiceImpl(tasksRepository: context.read())),
            ChangeNotifierProvider(
              create: (context) => HomeController(taskService: context.read()),
            ),
          ],
          routes: {
            '/home': (context) => HomePage(homeController: context.read()),
          },
        );
}
