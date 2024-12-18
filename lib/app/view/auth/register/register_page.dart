import 'package:flutter/material.dart';

import '../../../core/widget/todo_list_field.dart';
import '../../../core/widget/todo_list_logo.dart';
import '../../../core/ui/theme_extensions.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

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
                child: Column(
                  children: [
                    TodoListField(label: 'Email'),
                    const SizedBox(
                      height: 20,
                    ),
                    TodoListField(
                      label: 'Senha',
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TodoListField(
                      label: 'Confirme a senha',
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                        onPressed: () {},
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
