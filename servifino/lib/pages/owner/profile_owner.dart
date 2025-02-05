import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servifino/models/OwnerModel.dart';
import 'package:servifino/pages/owner/edit_profile_owner.dart';
import 'package:servifino/utils/app_routes.dart';
import 'package:servifino/utils/app_texts.dart';
import '../../models/UserModel.dart';
import '../../providers/user_provider.dart';
import '../../widgets/show_confirmation_dialog.dart';

class ProfileOwner extends StatelessWidget {
  final UserModel? user;
  final OwnerModel? owner;

  ProfileOwner({
    super.key,
    required this.user,
    required this.owner,
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
                  '${owner?.activityName ?? 'Configura attività'}',
                  style: TextStyle(
                    fontSize:
                        screenWidth * 0.05, // Ridotto per essere più compatto
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: screenHeight * 0.005), // Distanza adattata
                Text(
                  owner?.activityNumber ?? '',
                  style: TextStyle(
                    fontSize:
                        screenWidth * 0.04, // Ridotto per essere più compatto
                    color: Colors.white70,
                  ),
                ),
                SizedBox(height: screenHeight * 0.005), // Distanza adattata
                Text(
                  owner?.activityLocation ?? '',
                  style: TextStyle(
                    fontSize:
                        screenWidth * 0.03, // Ridotto per essere più compatto
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditOwnerProfileScreen(
                                owner: owner,
                                user: user,
                              )),
                    );
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
                    showConfirmationDialog(context,
                        title: AppTexts.controllers.logoutBtnTxt1,
                        message: AppTexts.controllers.logoutBtnTxt2,
                        onConfirm: () {
                      try {
                        // Richiama il logout dal provider
                        final userProvider =
                            Provider.of<UserProvider>(context, listen: false);
                        userProvider.logout();
                        //Navigator.of(context).pop(); // Chiudi il popup
                        Navigator.of(context)
                            .pushReplacementNamed(AppRoutes.authWrapper);
                      } catch (e) {
                        print('Error $e');
                      }
                    });
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
