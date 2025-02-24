import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servifino/providers/modelsProviders/user_provider.dart';
import 'package:servifino/providers/pagesProviders/login_provider.dart';
import 'package:servifino/utils/app_routes.dart';
import 'package:servifino/utils/app_texts.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppTexts.login.loginAppBarTitle),
      ),
      body: ChangeNotifierProvider(
        create: (_) => LoginProvider(),
        child: Consumer<LoginProvider>(
          builder: (context, loginProvider, _) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/logo.png",
                  width: 200,
                  height: 200,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: loginProvider.emailController,
                          decoration: InputDecoration(
                            labelText: AppTexts.controllers.email,
                            hintText: AppTexts.controllers.emailHint,
                            prefixIcon: const Icon(Icons.mail),
                          ),
                        ),
                        TextFormField(
                          controller: loginProvider.passwordController,
                          decoration: InputDecoration(
                            labelText: AppTexts.controllers.password,
                            hintText: AppTexts.controllers.passwordHint,
                            prefixIcon: const Icon(Icons.password),
                          ),
                          obscureText: true,
                        ),
                        const SizedBox(height: 16),
                        Center(
                          child: Text(
                            loginProvider.errorMessage,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () async {
                            if (loginProvider.passwordController.text.isEmpty ||
                                loginProvider.emailController.text.isEmpty) {
                              loginProvider
                                  .updateError(AppTexts.login.errorMessage);
                              return;
                            }
                            try {
                              // Effettua il login con Firebase Auth
                              UserCredential userCredential = await FirebaseAuth
                                  .instance
                                  .signInWithEmailAndPassword(
                                email: loginProvider.emailController.text,
                                password: loginProvider.passwordController.text,
                              );

                              // Ottieni l'ID dell'utente loggato
                              String uid = userCredential.user!.uid;
                              // Carica i dati dell'utente e aggiornali nel provider
                              final userProvider = Provider.of<UserProvider>(
                                  context,
                                  listen: false);
                              userProvider.fetchData(uid);
                              // Naviga alla HomeScreen
                              Navigator.pushReplacementNamed(
                                context,
                                AppRoutes.landing,
                              );
                            } catch (e) {
                              loginProvider
                                  .updateError(AppTexts.login.errorMessage);
                            }
                          },
                          child: Text(AppTexts.login.loginButton),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                              context,
                              AppRoutes.auth.register,
                            );
                          },
                          child: Text(AppTexts.login.createAccount),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
