import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:servifino/utils/app_routes.dart';

import '../../providers/user_provider.dart';
import '../../utils/app_texts.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  bool _isLoading = false;

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();
    final displayName = _displayNameController.text.trim();
    final phoneNumber = _phoneNumberController.text.trim();

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Le password non corrispondono!')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Chiamata al provider per registrare l'utente
      final userProvider = Provider.of<UserProvider>(context, listen: false);

      bool isRegistered = await userProvider.registerUser(
        email: email,
        password: password,
        displayName: displayName,
        phoneNumber: phoneNumber,
        photoURL: 'https://example.com/photo.jpg',
      );

      if (isRegistered) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registrazione avvenuta con successo!')),
        );
        Navigator.pushReplacementNamed(context, '/login'); // Naviga alla login
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Errore durante la registrazione')),
        );
      }
    } catch (e) {
      print('Errore: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Errore durante la registrazione')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppTexts.register.registerAppBarTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(AppTexts.register.textInfo1),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration:  InputDecoration(
                    labelText: AppTexts.controllers.email,
                    hintText: AppTexts.controllers.emailHint,
                    prefixIcon: Icon(Icons.mail)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppTexts.controllers.emailError;
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    labelText: AppTexts.controllers.password,
                    hintText: AppTexts.controllers.passwordHint,
                    prefixIcon: Icon(Icons.password)),
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 6) {
                    return AppTexts.controllers.passwordError;
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration:  InputDecoration(
                    labelText: AppTexts.controllers.confPassword,
                    hintText: AppTexts.controllers.confPasswordHint,
                    prefixIcon: Icon(Icons.password_rounded)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppTexts.controllers.confPasswordError;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Text(AppTexts.register.textInfo2),
              TextFormField(
                controller: _displayNameController,
                decoration:  InputDecoration(
                    labelText: AppTexts.controllers.displayName,
                    hintText: AppTexts.controllers.displayNameHint,
                    prefixIcon: Icon(Icons.person)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppTexts.controllers.displayNameError;
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneNumberController,
                keyboardType: TextInputType.number,
                decoration:  InputDecoration(
                  labelText: AppTexts.controllers.number,
                  hintText: AppTexts.controllers.numberHint,
                  prefixIcon: Icon(Icons.phone),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppTexts.controllers.numberError;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: _register,
                      child:  Text(AppTexts.register.registerButton),
                    ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, AppRoutes.login);
                },
                child:  Text(AppTexts.register.alreadyHaveAccount),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
