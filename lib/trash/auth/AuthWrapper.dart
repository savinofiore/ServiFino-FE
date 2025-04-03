import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servifino/providers/modelsProviders/owner_provider.dart';
import 'package:servifino/providers/modelsProviders/user_provider.dart';
import 'package:servifino/providers/modelsProviders/works_provider.dart';
import 'package:servifino/trash/login.dart';
import 'package:servifino/screens/landing/landing.dart';
/*
class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final authProvider = Provider.of<AuthProvider>(context);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final worksProvider = Provider.of<WorksProvider>(context, listen: false);
    final ownerProvider = Provider.of<OwnerProvider>(context, listen: false);

    // Se i dati sono in caricamento, mostra un indicatore di caricamento
    if (userProvider.isLoading ||
        worksProvider.isLoading ||
        ownerProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    // Se l'utente è autenticato, carica i dati e vai alla schermata principale
    if (userProvider.data != null) {
      log(userProvider.data.toString());
      //_loadUserData(context, authProvider.user!.uid); // Carica i dati dell'utente
      _loadData(
        userProvider.data!.uid,
        userProvider,
        worksProvider,
        ownerProvider,
      );
      return LandingScreen();
    }
    // Altrimenti, vai alla schermata di login
    return LoginScreen();
  }

  Future<void> _loadData(String uid, UserProvider userProvider,
      WorksProvider worksProvider, OwnerProvider ownerProvider) async {
    await userProvider.fetchData(uid);
    await worksProvider.fetchData(uid);
    if(userProvider.data!.isOwner){
      await ownerProvider.fetchData(userProvider.data!.uid);
      await ownerProvider.fetchAvailableNonOwnerUsers();
    }

  }
}
*/