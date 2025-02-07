import 'package:flutter/material.dart';
import 'package:servifino/providers/modelsProviders/owner_provider.dart';
import 'package:servifino/providers/modelsProviders/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:servifino/providers/modelsProviders/works_provider.dart';
import 'package:servifino/utils/app_routes.dart';

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final worksProvider = Provider.of<WorksProvider>(context, listen: false);
    final ownerProvider = Provider.of<OwnerProvider>(context, listen: false);

    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // Usa un controllo per verificare se la navigazione è necessaria
        WidgetsBinding.instance.addPostFrameCallback((_) {
          worksProvider.fetchData('');
          if (snapshot.hasData) {
            // Recupera i dati dell'utente
            userProvider.fetchData(snapshot.data!.uid).then((_) {
              // Azione da eseguire dopo fetchUserDataWithUid
              ownerProvider.fetchData(userProvider.data!.uid); // Richiama la tua funzione qui
            });
            // Naviga verso la schermata principale se non ci sei già
            if (ModalRoute.of(context)?.settings.name != AppRoutes.landing) {
              Navigator.pushReplacementNamed(context, AppRoutes.landing);
            }
          } else {
            // Naviga verso il Login se non ci sei già
            if (ModalRoute.of(context)?.settings.name != AppRoutes.auth.login) {
              Navigator.pushReplacementNamed(context, AppRoutes.auth.login);
            }
          }
        });

        return const SizedBox.shrink(); // Un widget vuoto come fallback
      },
    );
  }
}
