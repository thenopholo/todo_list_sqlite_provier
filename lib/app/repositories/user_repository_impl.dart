import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

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
}
