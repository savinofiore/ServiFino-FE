/*import 'package:flutter/material.dart';
import 'package:servifino/utils/request_errors.dart';

class RegisterProvider with ChangeNotifier {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _displayNameController = TextEditingController();
  //final TextEditingController _phoneNumberController = TextEditingController();

  bool isLoading = false;
  bool isOwner = false;

  // Getter per i controller
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get confirmPasswordController =>
      _confirmPasswordController;
  TextEditingController get displayNameController => _displayNameController;
  //TextEditingController get phoneNumberController => _phoneNumberController;


  void changeLoading(value){
    isLoading = value;
    notifyListeners();
  }

  void updateOwnerValue(bool available) {
    isOwner = available;
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
   // _phoneNumberController.dispose();
  }
}
*/


import 'package:flutter/material.dart';
import 'package:servifino/interfaces/BaseUIProvider.dart';
import 'package:servifino/utils/request_errors.dart';

class RegisterProvider extends BaseUIProvider {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _displayNameController = TextEditingController();

  bool isOwner = false;

  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get confirmPasswordController => _confirmPasswordController;
  TextEditingController get displayNameController => _displayNameController;

  void updateOwnerValue(bool available) {
    isOwner = available;
    notifyListeners();
  }

  RegistrationError validateFields() {
    if (_passwordController.text != _confirmPasswordController.text) {
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
