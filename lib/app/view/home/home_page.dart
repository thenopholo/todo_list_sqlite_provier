import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../../core/auth/app_auth_provider.dart';
import '../../core/ui/app_theme_extensions.dart';
import '../../core/ui/todo_list_icons.dart';
import 'widgets/home_drawer.dart';
import 'widgets/home_filters.dart';
import 'widgets/home_header.dart';
import 'widgets/home_task.dart';
import 'widgets/home_week_filter.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
            icon: IconButton(
              onPressed: () {},
              icon: const Icon(TodoListIcons.filter),
            ),
            itemBuilder: (_) => [
              const PopupMenuItem<bool>(
                child: Text('Concluídas'),
              )
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
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
