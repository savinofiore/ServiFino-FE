import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servifino/providers/user_provider.dart';

import '../../utils/app_routes.dart';
import '../../utils/app_texts.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String errorMessage = '';

  Future<void> login() async {
    try {
      // Effettua il login con Firebase Auth
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Ottieni l'ID dell'utente loggato
      String uid = userCredential.user!.uid;

      // Carica i dati dell'utente e aggiornali nel provider
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.fetchUserDataWithUid(uid);

      // Naviga alla HomeScreen
      Navigator.pushReplacementNamed(context, AppRoutes.landing);
    } catch (e) {
      print("Errore nel login: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(title: Text(AppTexts.login.loginAppBarTitle)),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _emailController,
                decoration:
                    InputDecoration(labelText: AppTexts.controllers.email),
              ),
              TextField(
                controller: _passwordController,
                decoration:
                    InputDecoration(labelText: AppTexts.controllers.password),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              if (errorMessage.isNotEmpty) ...[
                Text(
                  errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
                const SizedBox(height: 20),
              ],
              ElevatedButton(
                onPressed: login,
                child: Text(AppTexts.login.loginButton),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, AppRoutes.auth.register);
                },
                child: Text(AppTexts.login.createAccount),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
