import 'package:flutter/material.dart';

abstract class BaseUIProvider with ChangeNotifier {
  bool isLoading = false;

  void updateLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void disposeControllers();
}
