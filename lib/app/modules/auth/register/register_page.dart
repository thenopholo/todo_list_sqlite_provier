import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:validatorless/validatorless.dart';

import '../../../core/notifier/default_listener_notifier.dart';
import '../../../core/widget/todo_list_field.dart';
import '../../../core/widget/todo_list_logo.dart';
import '../../../core/ui/app_theme_extensions.dart';
import 'register_controller.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _confirmPasswordEC = TextEditingController();

  @override
  void initState() {
    super.initState();
    final defaultListener =
        DefaultListenerNotifier(notifier: context.read<RegisterController>());
    defaultListener.listener(
      context: context,
      successCallback: (notifier, listenerNotifier) {
        listenerNotifier.dispose();
      },
      errorCallback: (notifier, listenerNotifier) {
        log('Ocorrueu um erro');
      },
    );
  }

  @override
  void dispose() {
    _emailEC.dispose();
    _passwordEC.dispose();
    _confirmPasswordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Todo List', style: TextStyle(fontSize: 10)),
              Text('Cadastro', style: TextStyle(fontSize: 15)),
            ],
          ),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: ClipOval(
              child: Container(
                color: context.primaryColor.withAlpha(20),
                padding: const EdgeInsets.all(8),
                child: Icon(
                  Icons.arrow_back_ios_outlined,
                  size: 20,
                  color: context.primaryColor,
                ),
              ),
            ),
          ),
        ),
        body: ListView(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * .25,
              child: const FittedBox(
                fit: BoxFit.fitHeight,
                child: TodoListLogo(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TodoListField(
                      controller: _emailEC,
                      label: 'Email',
                      validator: Validatorless.multiple(
                        [
                          Validatorless.required('Campo Obrigatório'),
                          Validatorless.email('Email inválido'),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TodoListField(
                      controller: _passwordEC,
                      label: 'Senha',
                      obscureText: true,
                      validator: Validatorless.multiple(
                        [
                          Validatorless.required('Campo Obrigatório'),
                          Validatorless.min(
                              6, 'A senha deve ter no mínimo 6 caracteres'),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TodoListField(
                      controller: _confirmPasswordEC,
                      label: 'Confirme a senha',
                      obscureText: true,
                      validator: Validatorless.multiple(
                        [
                          Validatorless.required('Campo Obrigatório'),
                          Validatorless.compare(
                              _passwordEC, 'As senhas não são iguais'),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                        onPressed: () {
                          final formValid =
                              _formKey.currentState?.validate() ?? false;
                          if (formValid) {
                            final email = _emailEC.text;
                            final password = _passwordEC.text;
                            context
                                .read<RegisterController>()
                                .registerUser(email, password);
                          }
                        },
                        child: const Text('Salvar'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
