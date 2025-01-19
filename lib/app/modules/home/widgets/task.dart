import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/ui/app_theme_extensions.dart';
import '../../../models/task_model.dart';
import '../home_controller.dart';

class Task extends StatelessWidget {
  final TaskModel model;
  final dateFormat = DateFormat('dd/MM/yyyy');
  Task({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: context.primaryColor,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(45),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: ListTile(
          contentPadding: const EdgeInsets.all(8.0),
          leading: Checkbox(
            onChanged: (value) =>
                context.read<HomeController>().checkOrUncheckTask(model),
            value: model.isDone,
          ),
          title: Text(
            model.title,
            style: TextStyle(
              decoration: model.isDone ? TextDecoration.lineThrough : null,
            ),
          ),
          subtitle: Text(
            dateFormat.format(model.date),
            style: TextStyle(
              decoration: model.isDone ? TextDecoration.lineThrough : null,
            ),
          ),
          trailing: IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      title: Text(
                        'Apagar demanda?',
                        style: GoogleFonts.poppins(
                          color: context.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      content: Text(
                        'Está ação é irreversível.',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            context.read<HomeController>().deleteTask(model);
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Apagar',
                            style: GoogleFonts.poppins(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text(
                            'Cancelar',
                            style: GoogleFonts.poppins(
                              color: context.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    );
                  });
            },
            icon: const Icon(
              CupertinoIcons.delete,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
