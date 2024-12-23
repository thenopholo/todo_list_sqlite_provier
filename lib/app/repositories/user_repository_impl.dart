import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

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
      if(e.code == 'email-already-in-use') {
        // ignore: deprecated_member_use
        final loginTypes = await _auth.fetchSignInMethodsForEmail(email);
        if(loginTypes.contains('password')) {
          throw AuthException(message: 'E-mail já cadastrado');
        } else {
          throw AuthException(message: 'E-mail já cadastrado com o login do Google');
        } 
      } else {
        throw AuthException(message: 'Erro ao cadastrar usuário');
      }
    }
  }
}
