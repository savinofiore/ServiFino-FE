import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servifino/providers/pagesProviders/register_provider.dart';
import 'package:servifino/utils/app_routes.dart';
import 'package:servifino/utils/app_texts.dart';
import 'package:servifino/utils/request_errors.dart';
import 'package:servifino/widgets/show_message.dart';

import '../../providers/modelsProviders/user_provider.dart';

class RegisterScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //final registerProvider = context.read<RegisterProvider>();
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
        appBar: AppBar(
          title: Text(AppTexts.register.registerAppBarTitle),
        ),
        body: ChangeNotifierProvider(
          create: (_) => RegisterProvider(),
          child: Consumer<RegisterProvider>(
            builder: (context, registerProvider, _) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(AppTexts.register.textInfo1),
                      TextFormField(
                        controller: registerProvider.emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: AppTexts.controllers.email,
                          hintText: AppTexts.controllers.emailHint,
                          prefixIcon: const Icon(Icons.mail),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppTexts.controllers.emailError;
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: registerProvider.passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: AppTexts.controllers.password,
                          hintText: AppTexts.controllers.passwordHint,
                          prefixIcon: const Icon(Icons.password),
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length < 6) {
                            return AppTexts.controllers.passwordError;
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: registerProvider.confirmPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: AppTexts.controllers.confPassword,
                          hintText: AppTexts.controllers.confPasswordHint,
                          prefixIcon: const Icon(Icons.password_rounded),
                        ),
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
                        controller: registerProvider.displayNameController,
                        decoration: InputDecoration(
                          labelText: AppTexts.controllers.displayName,
                          hintText: AppTexts.controllers.displayNameHint,
                          prefixIcon: const Icon(Icons.person),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppTexts.controllers.displayNameError;
                          }
                          return null;
                        },
                      ),
                      /*TextFormField(
                        controller: registerProvider.phoneNumberController,
                        keyboardType: TextInputType.number,
                        enabled: false,
                        decoration: InputDecoration(
                          labelText: AppTexts.controllers.number,
                          hintText: AppTexts.controllers.numberHint,
                          prefixIcon: const Icon(Icons.phone),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppTexts.controllers.numberError;
                          }
                          return null;
                        },
                      ),*/
                      const SizedBox(height: 16),
                      Text(AppTexts.register.textInfo3),
                      SwitchListTile(
                        title: Text(AppTexts.register.textInfo4),
                        value: registerProvider.isOwner,
                        onChanged: (value) {
                          registerProvider.updateOwnerValue(value);
                        },
                      ),
                      const SizedBox(height: 16),
                      if (registerProvider.isLoading)
                        const Center(child: CircularProgressIndicator())
                      else
                        ElevatedButton(
                          onPressed: () async {
                            switch (registerProvider.validateFields()) {
                              case RegistrationError.success:
                                break;
                              case RegistrationError.dismatchPassword:
                                ShowMessageWidget(
                                  message:
                                      AppTexts.controllers.confPasswordError,
                                );
                                return;
                              case RegistrationError.error:
                                ShowMessageWidget(
                                  message: AppTexts
                                      .controllers.errorOperationMessage,
                                );
                                return;
                            }
                            registerProvider.updateLoading(true);
                            Map<String, dynamic> userData = {
                              'email':
                                  registerProvider.emailController.text.trim(),
                              'password':
                                  registerProvider.passwordController.text,
                              'displayName':
                                  registerProvider.displayNameController.text,
                              'isOwner': registerProvider.isOwner
                            };

                            switch (await userProvider.registerUser(userData)) {
                              case RequestError.done:
                                ShowMessageWidget(
                                  message: AppTexts.register.succRegMessagge,
                                );
                                String? userUid = await userProvider.login(
                                    email: registerProvider.emailController.text
                                        .trim(),
                                    password: registerProvider
                                        .passwordController.text);
                                await userProvider.fetchData(userUid!);
                                Navigator.pushReplacementNamed(
                                    context, AppRoutes.landing);
                                break;
                              case RequestError.error:
                                ShowMessageWidget(
                                    message: AppTexts.register.errRegMessagge);
                                break;
                            }
                            registerProvider.updateLoading(false);
                          },
                          child: Text(AppTexts.register.registerButton),
                        ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, AppRoutes.auth.login);
                        },
                        child: Text(AppTexts.register.alreadyHaveAccount),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }
}
