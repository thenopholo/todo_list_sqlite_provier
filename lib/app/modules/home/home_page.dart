import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../../core/auth/app_auth_provider.dart';
import '../../core/notifier/default_listener_notifier.dart';
import '../../core/ui/app_theme_extensions.dart';
import '../../core/ui/todo_list_icons.dart';
import '../../models/task_filter_enum.dart';
import '../tasks/task_create_page.dart';
import '../tasks/tasks_module.dart';
import 'home_controller.dart';
import 'widgets/home_drawer.dart';
import 'widgets/home_filters.dart';
import 'widgets/home_header.dart';
import 'widgets/home_task.dart';
import 'widgets/home_week_filter.dart';

class HomePage extends StatefulWidget {
  final HomeController _homeController;

  const HomePage({super.key, required HomeController homeController})
      : _homeController = homeController;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    DefaultListenerNotifier(notifier: widget._homeController).listener(
        context: context,
        successCallback: (notifier, listenerInstance) {
          listenerInstance.dispose();
        });

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        widget._homeController.loadAllTasks();
        widget._homeController.findTasks(filter: TaskFilterEnum.today);
      },
    );
  }

  Future<void> _goToCreateTask(BuildContext context) async {
    await Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 200),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          animation =
              CurvedAnimation(parent: animation, curve: Curves.easeInQuad);
          return ScaleTransition(
            scale: animation,
            alignment: Alignment.bottomCenter,
            child: child,
          );
        },
        pageBuilder: (context, animation, secondaryAnimation) {
          return TasksModule().getPage('/task/create', context);
        },
      ),
    );
    widget._homeController.refreshPage();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final appBarHeight = AppBar().preferredSize.height;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final totalHeight = screenHeight - appBarHeight - statusBarHeight;

    return Scaffold(
      backgroundColor: const Color(0xFFFAFBFE),
      appBar: AppBar(
        iconTheme: IconThemeData(color: context.primaryColor),
        backgroundColor: const Color(0xFFFAFBFE),
        elevation: 0,
        actions: [
          PopupMenuButton(
            onSelected: (value) => widget._homeController.showOrHideDoneTasks(),
            icon: const Icon(
              TodoListIcons.filter,
            ),
            itemBuilder: (_) => [
              PopupMenuItem<bool>(
                value: true,
                child: Text(
                    '${widget._homeController.showDoneTasks ? 'Ocultar' : 'Mostrar'} Concluídas'),
              )
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _goToCreateTask(context),
        backgroundColor: context.primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        child: const Icon(
          CupertinoIcons.plus,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 8.0,
          color: Colors.transparent,
          elevation: 5,
          child: Container(
            width: screenWidth,
            height: totalHeight * 0.08,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF687FF2), Color(0xFF3A71D6)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(CupertinoIcons.home, color: Colors.white),
                ),
                IconButton(
                  onPressed: () {},
                  icon:
                      const Icon(CupertinoIcons.calendar, color: Colors.white),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(CupertinoIcons.graph_circle,
                      color: Colors.white),
                ),
                IconButton(
                  onPressed: () {},
                  icon:
                      const Icon(CupertinoIcons.settings, color: Colors.white),
                ),
              ],
            ),
          )),
      drawer: HomeDrawer(),
      body: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
              minWidth: constraints.maxWidth,
            ),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: const IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HomeHeader(),
                    HomeFilters(),
                    HomeWeekFilter(),
                    HomeTask(),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
