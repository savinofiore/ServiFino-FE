import 'package:flutter/material.dart';
import 'package:servifino/interfaces/BaseUIProvider.dart';

class LoginProvider extends BaseUIProvider{
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String errorMessage = '';

  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;


  void updateError(String msgValue){
    errorMessage = msgValue;
    notifyListeners();
  }

  @override
  void disposeControllers() {
    _emailController.dispose();
    _passwordController.dispose();
  }

}