import 'package:flutter/material.dart';

import '../../../core/exception/auth_exception.dart';
import '../../../core/notifier/default_change_notifier.dart';
import '../../../services/user_service.dart';

class LoginController extends DefaultChangeNotifier {
  final UserService _userService;

  LoginController({required UserService userService})
      : _userService = userService;

  Future<void> login(String email, String password) async {
    try {
      showLoadingAndReset();
      notifyListeners();

      final user = await _userService.login(email, password);

      if (user != null) {
        success();
      } else {
        setError('Usuário ou senha inválidos.');
      }
    } on AuthException catch (e, s) {
      setError(e.message);
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}
