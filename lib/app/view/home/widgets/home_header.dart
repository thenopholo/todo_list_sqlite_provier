import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/auth/app_auth_provider.dart';
import '../../../core/ui/app_theme_extensions.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Selector<AppAuthProvider, String>(
            selector: (context, appAuthProvider) =>
                appAuthProvider.user?.displayName ?? 'Seja bem vindo(a)!',
            builder: (_, value, __) {
              return Text(
                'E ai, $value!',
                style: context.textTheme.headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              );
            },
          ),
        )
      ],
    );
  }
}
