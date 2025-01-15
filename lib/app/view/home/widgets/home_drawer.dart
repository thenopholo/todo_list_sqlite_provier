import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:provider/provider.dart';
import '../../../core/auth/app_auth_provider.dart';
import '../../../core/ui/app_theme_extensions.dart';
import '../../../core/utils/message.dart';
import '../../../services/user_service.dart';

class HomeDrawer extends StatelessWidget {
  final ValueNotifier<String> nameVN = ValueNotifier<String>('');

  HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: context.primaryColor.withAlpha(70),
            ),
            child: Row(
              spacing: 10,
              children: [
                Selector<AppAuthProvider, String>(
                  selector: (context, authProvider) {
                    return authProvider.user?.photoURL ??
                        'https://via.placeholder.com/150';
                  },
                  builder: (_, value, __) {
                    return CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(value),
                    );
                  },
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Selector<AppAuthProvider, String>(
                      selector: (context, authProvider) {
                        return authProvider.user?.displayName ??
                            'Não informado';
                      },
                      builder: (_, value, __) {
                        return Text(
                          value,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            onTap: () {
              showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    title: const Text('Alterar Nome'),
                    content: TextField(
                      onChanged: (value) => nameVN.value = value,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text(
                          'Cancelar',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          final newUserName = nameVN.value;
                          if (newUserName.isEmpty) {
                            Message.of(context).showError('Nome obrigatório.');
                          } else {
                            Loader.show(context);
                            await context
                                .read<UserService>()
                                .updateDisplayName(newUserName);
                            Loader.hide();
                            Navigator.of(context).pop();
                          }
                        },
                        child: Text(
                          'Confirmar',
                          style: TextStyle(
                            color: context.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            title: Text('Alterar Nome'),
          ),
          ListTile(
            onTap: () => context.read<AppAuthProvider>().logout(),
            title: const Text('Sair'),
          ),
        ],
      ),
    );
  }
}
