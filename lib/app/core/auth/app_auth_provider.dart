import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../services/user_service.dart';
import '../navigator/todo_list_navigator.dart';

class AppAuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth;
  final UserService _userService;

  AppAuthProvider({
    required FirebaseAuth auth,
    required UserService userService,
  })  : _auth = auth,
        _userService = userService;

  Future<void> logout() => _userService.logout();
  User? get user => _auth.currentUser;

  void loadListener() {
    _auth.userChanges().listen((_) => notifyListeners());
    _auth.idTokenChanges().listen(
      (user) {
        if (user != null) {
          TodoListNavigator.to
              .pushNamedAndRemoveUntil('/home', (route) => false);
        } else {
          TodoListNavigator.to
              .pushNamedAndRemoveUntil('/login', (route) => false);
        }
      },
    );
  }
}
