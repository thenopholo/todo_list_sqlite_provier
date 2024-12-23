import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:provider/provider.dart';
import 'package:validatorless/validatorless.dart';

import '../../../core/notifier/default_listener_notifier.dart';
import '../../../core/widget/todo_list_field.dart';
import '../../../core/widget/todo_list_logo.dart';
import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();

  @override
  void initState() {
    super.initState();
    DefaultListenerNotifier(notifier: context.read<LoginController>()).listener(
        context: context, successCallback: (notifier, listenersNotifier) {
          log('Login concluido com sucesso.');
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
                minWidth: constraints.maxWidth,
              ),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 48),
                    const TodoListLogo(),
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TodoListField(
                              controller: _emailEC,
                              validator: Validatorless.multiple([
                                Validatorless.required('Email Obrigatório'),
                                Validatorless.email('Email inválido'),
                              ]),
                              label: 'Email',
                            ),
                            const SizedBox(height: 20),
                            TodoListField(
                              controller: _passwordEC,
                              validator: Validatorless.multiple([
                                Validatorless.required('Senha Obrigatório'),
                                Validatorless.min(6,
                                    'Senha muito curta, minimo 6 caracteres'),
                              ]),
                              label: 'Senha',
                              obscureText: true,
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () {},
                                  child: const Text('Esqueçeu sua senha?'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    final formValid =
                                        _formKey.currentState?.validate() ??
                                            false;
                                    if (formValid) {
                                      final email = _emailEC.text;
                                      final password = _passwordEC.text;
                                      context
                                          .read<LoginController>()
                                          .login(email, password);
                                    }
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text('Entrar'),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0XFFF0F3F7),
                          border: Border(
                            top: BorderSide(
                              width: 2,
                              color: Colors.grey.withAlpha(50),
                            ),
                          ),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            SignInButton(
                              Buttons.Google,
                              text: 'Entrar com Google',
                              padding: const EdgeInsets.all(5),
                              shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                              onPressed: () {},
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Não tem uma conta?'),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed('/register');
                                  },
                                  child: const Text('Cadastre-se!'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
