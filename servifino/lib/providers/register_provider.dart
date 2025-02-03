import 'dart:async';
import 'dart:developer';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import '../providers/user_provider.dart';
import '../utils/app_texts.dart';

enum RegistrationError {
  success,
  error,
  dismatchPassword,
}

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

  Future<void> writeMessage(String message) async {
    HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('createUser');
    final resp = await callable.call(<String, dynamic>{
      'email': 'test1810@example.com',
      'password': 'SecurePassword123',
      'displayName': 'John Doe',
      'phoneNumber': '+391213450027',
      'photoURL': 'https://example.com/photo.jpg'
    });
    print("result: ${resp.data}");
  }

/*
  // Metodo per la registrazione
  Future<void> register() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      // return RegistrationError.dismatchPassword;
      log('Password non coincidono');
      return;
    }
    isLoading = true;

    //try {
    HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('createUser');
    final resp = await callable.call(<String, dynamic>{
      "email": _emailController.text.trim(),
      "password": _passwordController.text.trim(),
      "displayName": _displayNameController.text.trim(),
      "phoneNumber": _phoneNumberController.text.trim(),
      "photoURL": "https://example.com/photo.jpg"
    });
    print("result: ${resp.data}");

    //log("User created successfully: ${response.data}");
    /*} catch (e) {
      log("Error creating user: $e");
    }


    /*
    try {
      final bool requestError = await userProvider.registerUser(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        displayName: _displayNameController.text.trim(),
        phoneNumber: _phoneNumberController.text.trim(),
        photoURL: AppTexts.utils.photoExampleUrl,
      );
      if (requestError == true) {
        log('User created ${emailController.text}');
      } else {
        return RegistrationError.error;
      }
      return RegistrationError.success;
    } catch (e) {
      log('error');
      return RegistrationError.error;
    }
    */

    finally {
      notifyListeners();
    }*/
  }*/

  // Metodo per pulire i controller
  void disposeControllers() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _displayNameController.dispose();
    _phoneNumberController.dispose();
  }
}
