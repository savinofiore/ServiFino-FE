import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servifino/models/UserModel.dart';
import 'package:servifino/utils/app_routes.dart';
import '../../models/WorksModel.dart';
import '../../providers/edit_profile_worker_provider.dart';
import '../../providers/user_provider.dart';
import '../../utils/app_texts.dart';
import '../../widgets/show_confirmation_dialog.dart';

class EditProfileScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  late UserModel? user;
  late List<WorkModel>? works;

  EditProfileScreen({super.key, required this.user, required this.works});

  Future<void> _saveProfile(BuildContext context) async {
    // Verifica la validità del form
    if (!_formKey.currentState!.validate()) return;
    final profileEditorProvider = context.read<ProfileEditProvider>();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      // Chiama la funzione saveChanges e attendi la risposta
      final statusCode = await profileEditorProvider.saveChanges(user, userProvider);

      // Verifica se la risposta è valida e ha status code 200
      if (statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppTexts.profile.successMessage)),
        );
        Navigator.pushReplacementNamed(context, AppRoutes.landing);
      } else {
        throw '${AppTexts.controllers.errorEditTxt1}: ${statusCode}';
      }
    } catch (e) {
      // Gestisci l'errore e mostra un messaggio all'utente
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${AppTexts.profile.errorMessage}: $e')),
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
                child: provider.isLoading == true
                    ? // Mostra il CircularProgressIndicator durante il caricamento
                    const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 4,
                        ),
                      )
                    : SingleChildScrollView(
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
                              onPressed: () {
                                showConfirmationDialog(context,
                                    title: AppTexts.controllers.editBtnTxt1,
                                    message: AppTexts.controllers.editBtnTxt2,
                                    onConfirm: () => _saveProfile(context));
                              },
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
