import 'package:flutter/material.dart';
import 'package:servifino/providers/modelsProviders/owner_provider.dart';
import 'package:servifino/providers/modelsProviders/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:servifino/providers/modelsProviders/works_provider.dart';
import 'package:servifino/screens/authentication/login.dart';
import 'package:servifino/screens/landing/landing.dart';

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final worksProvider = Provider.of<WorksProvider>(context, listen: false);
    final ownerProvider = Provider.of<OwnerProvider>(context, listen: false);

    Future<void> _fetchData(AsyncSnapshot<User?> snapshot) async {
      await userProvider.fetchData(snapshot.data!.uid);
      await worksProvider.fetchData('');
      if (userProvider.data!.isOwner) {
        await ownerProvider.fetchData(snapshot.data!.uid);
        await ownerProvider.fetchAvailableNonOwnerUsers();
      }
    }

    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          _fetchData(snapshot);
          return LandingScreen();
        } else {
          return LoginScreen();
        }
      },
    );
  }
}
