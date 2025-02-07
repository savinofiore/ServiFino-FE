import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:servifino/models/UserModel.dart';
import 'package:servifino/utils/request_errors.dart';
import 'package:servifino/widgets/show_message.dart';
import '../../models/WorksModel.dart';
import '../../providers/pagesProviders/edit_profile_worker_provider.dart';
import '../../providers/modelsProviders/user_provider.dart';
import '../../utils/app_texts.dart';
import '../../widgets/show_confirmation_dialog.dart';

class EditProfileScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  late UserModel? user;
  late List<WorkModel>? works;

  EditProfileScreen({super.key, required this.user, required this.works});

  Future<RequestError> _saveProfile(
      BuildContext context, ProfileEditProvider provider) async {
    if (!_formKey.currentState!.validate()) return RequestError.error;

    final userProvider = Provider.of<UserProvider>(context, listen: false);

    Map<String, dynamic> updates = {
      'userId': user!.uid,
      'displayName': provider.displayNameController.text,
      'work': provider.selectedWorkId,
      'isAvailable': provider.isAvailable
    };

    try {
      final RequestError requestError = await userProvider.updateData(updates);
      return requestError;
    } catch (e) {
      return RequestError.error;
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
                              enabled: false,
                              decoration: InputDecoration(
                                labelText: AppTexts.controllers.email,
                                hintText: AppTexts.controllers.emailHint,
                                prefixIcon: const Icon(Icons.mail),
                              ),
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
                            provider.isLoading == false
                                ? Container()
                                : const CircularProgressIndicator(),
                            ElevatedButton(
                              onPressed: () {
                                showConfirmationDialog(context,
                                    title: AppTexts.controllers.editBtnTxt1,
                                    message: AppTexts.controllers.editBtnTxt2,
                                    onConfirm: () async => {
                                          provider.updateLoading(true),
                                          switch (await _saveProfile(
                                              context, provider)) {
                                            RequestError.done => {
                                                ShowMessageWidget(
                                                  message: AppTexts
                                                      .profile.successMessage,
                                                ),
                                              },
                                            RequestError.error =>
                                              ShowMessageWidget(
                                                message: AppTexts
                                                    .profile.errorMessage,
                                              )
                                          },
                                          provider.updateLoading(false)
                                        });
                              },
                              child: Text(AppTexts.controllers.save),
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
