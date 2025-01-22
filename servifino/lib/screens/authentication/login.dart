import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servifino/providers/user_provider.dart';

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
      userProvider.fetchUserData(uid);

      // Naviga alla HomeScreen
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      print("Errore nel login: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
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
              child: const Text('Sign In'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/register');
              },
              child: const Text('Don\'t have an account? Register'),
            ),
          ],
        ),
      ),
    );
  }
}
