import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:servifino/auth_router_wrapper.dart';
import 'package:servifino/providers/user_provider.dart';
import 'package:servifino/screens/authentication/register.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'screens/home.dart';
import 'screens/authentication/login.dart';

Future<void> main() async {
  // Assicurati che il binding di Flutter sia inizializzato
  WidgetsFlutterBinding.ensureInitialized();
  // Inizializza Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Avvia l'app
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MaterialApp(
        title: 'ServiFino',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) =>
              AuthWrapper(), // Definisci la rotta principale (autenticazione)
          '/home': (context) => HomeScreen(), // La rotta per la home screen
          '/login': (context) => LoginScreen(), // La rotta per la login screen
          '/register': (context) => RegisterScreen(),
        }, // Questo controllerà la logica di login
      ),
    );
  }
} test@test.test
