import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servifino/models/UserModel.dart';
import 'package:servifino/utils/app_routes.dart';
import '../../models/WorksModel.dart';
import '../../providers/edit_profile_worker_provider.dart';
import '../../utils/app_texts.dart';

class EditProfileScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  late UserModel? user;
  late List<WorkModel>? works;

  EditProfileScreen({super.key, required this.user, required this.works});

  Future<void> _saveProfile(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    final provider = context.read<ProfileEditProvider>();

    try {
      await provider.saveChanges();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppTexts.profile.successMessage)),
      );
      Navigator.pushReplacementNamed(context, AppRoutes.landing);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppTexts.profile.errorMessage)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppTexts.profile.editProfileAppBarTitle),
      ),
      body: ChangeNotifierProvider(
        create: (_) => ProfileEditProvider(works: works, user: user),
        child: Consumer<ProfileEditProvider>(
          builder: (context, provider, _) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        controller: provider.displayNameController,
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
                      TextFormField(
                        controller: provider.emailController,
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
                        controller: provider.phoneNumberController,
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
                      ),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: AppTexts.controllers.work,
                          hintText: AppTexts.controllers.workHint,
                          prefixIcon: const Icon(Icons.work),
                        ),
                        value: provider.selectedWorkId,
                        items: works
                            ?.map((work) => DropdownMenuItem<String>(
                                  value: work.id,
                                  child: Text(work.name),
                                ))
                            .toList(),
                        onChanged: (value) {
                          provider.updateSelectedWork(value!);
                        },
                      ),
                      SwitchListTile(
                        title: Text(provider.isAvailable
                            ? AppTexts.utils.available
                            : AppTexts.utils.notAvailable),
                        value: provider.isAvailable,
                        onChanged: (value) {
                          provider.updateAvailability(value);
                        },
                      ),
                      ElevatedButton(
                        onPressed: () => _saveProfile(context),
                        child: Text(AppTexts.controllers.save),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, AppRoutes.landing);
                        },
                        child: Text(AppTexts.controllers.cancel),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
