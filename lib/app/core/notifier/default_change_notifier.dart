
import 'package:flutter/material.dart';

class DefaultChangeNotifier extends ChangeNotifier {
  bool _isLoading = false;
  String? _error;
  bool _success = false;

  bool get isLoading => _isLoading;
  String? get error  => _error;
  bool get hasError => _error != null;
  bool get isCompleteWithSuccess => _success;

  void showLoading() => _isLoading = true;
  void hideLoading() => _isLoading = false;
  void success() => _success = true;
  void setError(String message) => _error = message;
  void showLoadingAndReset() {
    showLoading();
    resetState();
  }
  void resetState() {
    _error = null;
    _success = false;
  }
}