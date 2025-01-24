import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servifino/providers/user_provider.dart';
import 'package:servifino/utils/app_routes.dart';
import 'package:servifino/utils/app_texts.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppTexts.home.homeTitle),
        actions: [
          IconButton(
            onPressed: () {
              try {
                userProvider.logout();
                Navigator.pushReplacementNamed(context, AppRoutes.login);
              } catch (e) {
                print(e);
              }
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Center(
        child: user == null
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Welcome, ${user.displayName}'),
                  Text('Email: ${user.email}'),
                  Text('Phone: ${user.phoneNumber ?? "N/A"}'),
                  Text('Assignment: ${user.assignment}'),
                  //Text('Age: ${user.age ?? "N/A"}'),
                ],
              ),
      ),
    );
  }
}
