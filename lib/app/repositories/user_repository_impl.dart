import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../core/exception/auth_exception.dart';
import './user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  FirebaseAuth _auth = FirebaseAuth.instance;

  UserRepositoryImpl({required FirebaseAuth auth}) : _auth = auth;

  @override
  Future<User?> register(String email, String password) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e, s) {
      log('Erro: ${e.code}', error: e, stackTrace: s);
      if (e.code == 'email-already-in-use') {
        // ignore: deprecated_member_use
        final loginTypes = await _auth.fetchSignInMethodsForEmail(email);
        if (loginTypes.contains('password')) {
          throw AuthException(message: 'E-mail já cadastrado');
        } else {
          throw AuthException(
              message: 'E-mail já cadastrado com o login do Google');
        }
      } else {
        throw AuthException(message: 'Erro ao cadastrar usuário');
      }
    }
  }

  @override
  Future<User?> login(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } on PlatformException catch (e, s) {
      log('Erro: ${e.code}', error: e, stackTrace: s);
      throw AuthException(message: e.message ?? 'Erro ao realizar o Login');
    } on FirebaseAuthException catch (e, s) {
      log('Erro: ${e.code}', error: e, stackTrace: s);
      if (e.code == 'invalid-credential') {
        throw AuthException(message: 'Email ou senha incorreta');
      }
      throw AuthException(message: e.message ?? 'Erro ao realizar o Login');
    }
  }

  @override
  Future<User?> forgotPassword(String email) async {
    try {
      // ignore: deprecated_member_use
      final loginMethods = await _auth.fetchSignInMethodsForEmail(email.trim());
      log('Métodos de login para $email: $loginMethods');

      if (loginMethods.contains('password')) {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      } else if (loginMethods.contains('google')) {
        throw AuthException(
          message:
              'Cadastro realizado com o Google. Utilize o login do Google para recuperar a senha.',
        );
      } else {
        log('Métodos de login para $email: $loginMethods');
        throw AuthException(
          message: 'E-mail não cadastrado.',
        );
      }
    } on FirebaseAuthException catch (e, s) {
      log('Erro: ${e.code}', error: e, stackTrace: s);
      throw AuthException(message: 'Erro ao resetar a senha');
    }
  }

  @override
  Future<User?> googleLogin() async {
    try {
      final googleSignIn = GoogleSignIn();
      final googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        throw AuthException(
            message: 'Login com Google cancelado pelo usuário.');
      }

      final email = googleUser.email.toLowerCase().trim();
      // ignore: deprecated_member_use
      final loginMethods = await _auth.fetchSignInMethodsForEmail(email);

      if (loginMethods.contains('password')) {
        throw AuthException(
          message:
              'Você já possui um cadastro com esse e-mail. Por favor, utilize o login com e-mail e senha, ou clique em esqueci minha senha.',
        );
      }

      if (loginMethods.contains('google.com')) {
        final googleAuth = await googleUser.authentication;
        final firebaseCredential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        var userCredential =
            await _auth.signInWithCredential(firebaseCredential);
        return userCredential.user;
      }

      throw AuthException(
          message: 'Erro: Conta já existente com outro método de login.');
    } on FirebaseAuthException catch (e, s) {
      log('Erro ao logar com Google: ${e.code}', error: e, stackTrace: s);

      if (e.code == 'account-exists-with-different-credential') {
        final existingMethods =
            await _auth.
            // ignore: deprecated_member_use
            fetchSignInMethodsForEmail(e.email ?? '');
        throw AuthException(
          message:
              'Você já possui um cadastro com esse e-mail, mas com outro provedor. Métodos disponíveis: $existingMethods',
        );
      } else {
        throw AuthException(message: 'Erro ao realizar o login com o Google');
      }
    }
  }

  @override
  Future<void> googleLogout() async {
    await GoogleSignIn().signOut();
    _auth.signOut();
  }
}
