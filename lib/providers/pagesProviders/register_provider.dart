import 'package:flutter/material.dart';
import 'package:servifino/interfaces/BaseUIProvider.dart';
import 'package:servifino/utils/app_texts.dart';
import 'package:servifino/utils/request_errors.dart';

class RegisterProvider extends BaseUIProvider {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _displayNameController = TextEditingController();

  bool isOwner = false;
  bool isError = true;
  String errorMessage = '';

  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get confirmPasswordController => _confirmPasswordController;
  TextEditingController get displayNameController => _displayNameController;

  void updateOwnerValue(bool available) {
    isOwner = available;
    notifyListeners();
  }

  void updateError(bool errorValue, String msgValue){
    isError = errorValue;
    errorMessage = msgValue;
    notifyListeners();
  }

  RegistrationError validateFields() {
    if(_emailController.text.isEmpty || _displayNameController.text.isEmpty){
      updateError(true, AppTexts.controllers.emptyValueError);
      return RegistrationError.error;
    }
    if (_passwordController.text != _confirmPasswordController.text) {
      updateError(true, AppTexts.controllers.confPasswordError);
      return RegistrationError.dismatchPassword;
    }
    if(_passwordController.text.length < 6 ){
      updateError(true, AppTexts.controllers.lenghtPasswordError);
      return RegistrationError.dismatchPassword;
    }
    return RegistrationError.success;
  }

  @override
  void disposeControllers() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _displayNameController.dispose();
  }
}
