import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';

import '../../core/notifier/default_listener_notifier.dart';
import '../../core/ui/app_theme_extensions.dart';
import 'task_create_controller.dart';
import 'widgets/task_calendar_button.dart';

class TaskCreatePage extends StatefulWidget {
  final TaskCreateController _controller;

  TaskCreatePage({
    super.key,
    required TaskCreateController controller,
  }) : _controller = controller;

  @override
  State<TaskCreatePage> createState() => _TaskCreatePageState();
}

class _TaskCreatePageState extends State<TaskCreatePage> {
  final _titleEC = TextEditingController();
  final _descriptionEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    DefaultListenerNotifier(
      notifier: widget._controller,
    ).listener(
        context: context,
        successCallback: (notifier, lsitenerInstance) {
          lsitenerInstance.dispose();
          Navigator.of(context).pop();
        });
  }

  @override
  void dispose() {
    super.dispose();
    _titleEC.dispose();
    _descriptionEC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final appBarHeight = AppBar().preferredSize.height;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final totalHeight = screenHeight - appBarHeight - statusBarHeight;

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          final formValid = _formKey.currentState?.validate() ?? false;
          if (formValid) {
            widget._controller.saveTask(_titleEC.text, _descriptionEC.text);
          }
        },
        backgroundColor: context.primaryColor,
        foregroundColor: Colors.white,
        label: Text(
          'Salvar Task',
          selectionColor: context.primaryColor,
        ),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: appBarHeight + statusBarHeight,
              ),
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(
                  Icons.close_rounded,
                  color: context.primaryColor,
                ),
              ),
            ],
          ),
          Form(
            key: _formKey,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              height: totalHeight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 20,
                children: [
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Criar Nova Task',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D3748),
                      ),
                    ),
                  ),
                  Column(
                    spacing: 10,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              offset: Offset(2, 5),
                            ),
                          ],
                        ),
                        child: TextFormField(
                          controller: _titleEC,
                          validator:
                              Validatorless.required('Título obrigatório'),
                          decoration: InputDecoration(
                            labelText: 'Dê um título para essa demanda',
                            labelStyle: TextStyle(color: context.primaryColor),
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: context.primaryColor),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: context.primaryColor),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                          ),
                        ),
                      ),
                      Container(
                        height: totalHeight * 0.3,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              offset: Offset(2, 5),
                            ),
                          ],
                        ),
                        child: TextFormField(
                          controller: _descriptionEC,
                          maxLines: null,
                          expands: true,
                          textAlignVertical: TextAlignVertical.top,
                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            labelText: 'Detalhes da demanda',
                            labelStyle: TextStyle(color: context.primaryColor),
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: context.primaryColor),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: context.primaryColor),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                  TaskCalendarButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
