import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servifino/utils/app_routes.dart';
import 'package:servifino/utils/app_texts.dart';
import '../../models/UserModel.dart';
import '../../providers/user_provider.dart';

class ProfileWorker extends StatelessWidget {
  final UserModel? user;

  ProfileWorker({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    // Ottieni le dimensioni dello schermo
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header: User Information
          Container(
            padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.02, horizontal: screenWidth * 0.05),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.blueAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: screenWidth * 0.1, // Ridotto per essere più compatto
                  backgroundColor: Colors.blueAccent,
                  child: const Icon(
                    Icons.person,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01), // Distanza adattata
                Text(
                  '${user?.displayName} (${user?.work})' ??
                      'Nome non disponibile',
                  style: TextStyle(
                    fontSize:
                        screenWidth * 0.05, // Ridotto per essere più compatto
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: screenHeight * 0.005), // Distanza adattata
                Text(
                  user!.email,
                  style: TextStyle(
                    fontSize:
                        screenWidth * 0.04, // Ridotto per essere più compatto
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.03), // Adatta la distanza

          // User Actions: List of options with arrow to the right
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Column(
              children: [
                // Edit Profile
                ListTile(
                  leading: const Icon(Icons.edit, color: Colors.blueAccent),
                  title: Text(AppTexts.controllers.editProfileBtn),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // Handle edit profile action
                  },
                ),
                const Divider(),
                // Settings
                ListTile(
                  leading: const Icon(Icons.settings, color: Colors.grey),
                  title: Text(AppTexts.controllers.settingBtn),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // Handle settings action
                  },
                ),
                const Divider(),
                // Logout
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.redAccent),
                  title: Text(AppTexts.controllers.logoutBtn),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // Mostra il popup di conferma
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title:  Text(AppTexts.controllers.logoutBtnTxt1),
                          content:  Text(AppTexts.controllers.logoutBtnTxt2),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Chiudi il popup
                              },
                              child:  Text(AppTexts.controllers.cancel),
                            ),
                            TextButton(
                              onPressed: () {
                                // Richiama il logout dal provider
                                final userProvider = Provider.of<UserProvider>(context, listen: false);
                                userProvider.logout();
                                Navigator.of(context).pop(); // Chiudi il popup
                                Navigator.of(context).pushReplacementNamed(AppRoutes.auth.login);
                              },
                              child:  Text(AppTexts.controllers.confirm),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                const Divider(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
