import 'package:flutter/material.dart';
import 'package:servifino/utils/request_errors.dart';

class RegisterProvider with ChangeNotifier {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  bool _isLoading = false;

  // Getter per i controller
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get confirmPasswordController =>
      _confirmPasswordController;
  TextEditingController get displayNameController => _displayNameController;
  TextEditingController get phoneNumberController => _phoneNumberController;

  // Getter e setter per lo stato di caricamento
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  RegistrationError validateFields() {
    if (_passwordController.text != _confirmPasswordController.text) {
      return RegistrationError.dismatchPassword;
    }
    return RegistrationError.success;
  }

  // Metodo per pulire i controller
  void disposeControllers() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _displayNameController.dispose();
    _phoneNumberController.dispose();
  }
}
