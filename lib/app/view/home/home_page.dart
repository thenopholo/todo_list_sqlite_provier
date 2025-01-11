import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/auth/app_auth_provider.dart';
import 'widgets/home_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      drawer: HomeDrawer(),
      body: Container(),
    );
  }
}