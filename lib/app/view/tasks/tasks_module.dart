import 'package:provider/provider.dart';

import '../../core/modules/todo_list_modules.dart';
import '../../repositories/tasks/tasks_repository.dart';
import '../../repositories/tasks/tasks_repository_impl.dart';
import '../../services/task/task_service.dart';
import '../../services/task/task_service_impl.dart';
import 'task_create_controller.dart';
import 'task_create_page.dart';

class TasksModule extends TodoListModules {
  TasksModule()
      : super(
          bindings: [
            Provider<TasksRepository>(
                create: (context) =>
                    TasksRepositoryImpl(connectionFactory: context.read())),
            Provider<TaskService>(
                create: (context) =>
                    TaskServiceImpl(tasksRepository: context.read())),
            ChangeNotifierProvider(
                create: (context) =>
                    TaskCreateController(taskService: context.read())),
          ],
          routes: {
            '/task/create': (context) =>
                TaskCreatePage(controller: context.read()),
          },
        );
}
