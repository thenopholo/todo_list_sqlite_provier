import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

import '../utils/message.dart';
import 'default_change_notifier.dart';

class DefaultListenerNotifier {
  final DefaultChangeNotifier notifier;

  DefaultListenerNotifier({
    required this.notifier,
  });

  void listener({
    required BuildContext context,
    required SuccessVoidCallback successCallback,
    AwaysVoidCallback? awaysCallback,
    ErrorvoidCallback? errorCallback,
  }) {
    notifier.addListener(
      () {
        if (awaysCallback != null) {
          awaysCallback(notifier, this);
        }
        if (notifier.isLoading) {
          Loader.show(context);
        } else {
          Loader.hide();
        }

        if (notifier.hasError) {
          if (errorCallback != null) {
            errorCallback(notifier, this);
          }
          Message.of(context).showError(notifier.error ?? 'Internal error');
        } else if (notifier.isCompleteWithSuccess) {
          successCallback(notifier, this);
        }
      },
    );
  }

  void dispose() {
    notifier.removeListener(() {});
  }
}

typedef SuccessVoidCallback = void Function(
    DefaultChangeNotifier notifier, DefaultListenerNotifier listenerNotifier);

typedef ErrorvoidCallback = void Function(
    DefaultChangeNotifier notifier, DefaultListenerNotifier listenerNotifier);

typedef AwaysVoidCallback = void Function(
    DefaultChangeNotifier notifier, DefaultListenerNotifier listenerNotifier);
