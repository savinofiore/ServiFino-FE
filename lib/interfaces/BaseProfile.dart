import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servifino/models/WorksModel.dart';
import 'package:servifino/pages/edit_profile.dart';
import 'package:servifino/utils/app_routes.dart';
import 'package:servifino/utils/app_texts.dart';
import '../../models/UserModel.dart';
import '../../providers/modelsProviders/user_provider.dart';
import '../../widgets/show_confirmation_dialog.dart';

abstract class ProfileBase extends StatelessWidget {
  final String title;
  final String subtitle;
  final UserModel? user;
  final List<WorkModel>? works;
  final Widget? additionalWidget;
  //final Widget editProfilePage;

  ProfileBase({
    super.key,
    required this.title,
    required this.subtitle,
    required this.user,
    required this.works,
    required this.additionalWidget
    //required this.editProfilePage,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.02, horizontal: screenWidth * 0.05),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFD4B773), Color(0xFFD4B773)],
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
                Text(
                  title,
                  style: TextStyle(
                    fontSize: screenWidth * 0.05,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: screenHeight * 0.005),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.03),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Column(
              children: [
                additionalWidget ?? Container(),
                ListTile(
                  leading: const Icon(Icons.edit,
                    //color: Colors.blueAccent,
                    ),
                  title: Text(AppTexts.controllers.editProfileBtn),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditUserPage(user: user, works: works)),
                    );
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.settings, color: Colors.grey),
                  title: Text(AppTexts.controllers.settingBtn),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {},
                ),
                const Divider(),
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
                            final userProvider =
                            Provider.of<UserProvider>(context, listen: false);
                            userProvider.logout();
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
