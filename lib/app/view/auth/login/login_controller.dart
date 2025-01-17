import 'dart:developer';

import '../../../core/exception/auth_exception.dart';
import '../../../core/notifier/default_change_notifier.dart';
import '../../../services/user/user_service.dart';

class LoginController extends DefaultChangeNotifier {
  final UserService _userService;
  String? infoMessage;

  LoginController({required UserService userService})
      : _userService = userService;

  bool get hasInfo => infoMessage != null;

  Future<void> googleLogin() async {
    try {
      showLoadingAndReset();
      infoMessage = null;
      notifyListeners();
      final user = await _userService.googleLogin();

      if (user != null) {
        success();
      } else {
        await _userService.logout();
        setError('Erro ao realizar o login com o Google.');
      }
    } on AuthException catch (e) {
      await _userService.logout();
      setError(e.message);
    } finally {
      hideLoading();
      notifyListeners();
    }
  }

  Future<void> login(String email, String password) async {
    try {
      showLoadingAndReset();
      infoMessage = null;
      notifyListeners();

      final user = await _userService.login(email, password);

      if (user != null) {
        success();
      } else {
        setError('Usuário ou senha inválidos.');
      }
    } on AuthException catch (e, s) {
      log(e.message, error: e, stackTrace: s);
      setError(e.message);
    } finally {
      hideLoading();
      notifyListeners();
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      showLoadingAndReset();
      infoMessage = null;
      notifyListeners();
      await _userService.forgotPassword(email);
      infoMessage = 'Reset de senha enviado para seu email.';
    } on AuthException catch (e) {
      setError(e.message);
    } catch (e) {
      setError('Erro ao enviar o reset de senha.');
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}
