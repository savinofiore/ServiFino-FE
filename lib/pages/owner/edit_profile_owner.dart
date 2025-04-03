import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servifino/models/OwnerModel.dart';
import 'package:servifino/models/UserModel.dart';
import 'package:servifino/providers/pagesProviders/edit_profile_owner_provider.dart';
import 'package:servifino/providers/modelsProviders/owner_provider.dart';
import 'package:servifino/utils/app_texts.dart';
import 'package:servifino/utils/request_errors.dart';

class EditOwnerProfileScreen extends StatelessWidget {
  final OwnerModel? owner;
  final UserModel? user;
  final _formKey = GlobalKey<FormState>();

  EditOwnerProfileScreen({
    super.key,
    required this.owner,
    required this.user,
  });

  Future<RequestError> _saveProfile(
      BuildContext context, EditOwnerProfileProvider provider) async {
    if (!_formKey.currentState!.validate()) return RequestError.error;

    final ownerProvider = Provider.of<OwnerProvider>(context, listen: false);

    final Map<String, dynamic> ownerData = {
      'userUid': user!.uid,
      'activityName': provider.activityNameController.text,
      'activityDescription': provider.activityDescriptionController.text,
      'activityLocation': provider.activityLocationController.text,
      'activityWebsite': provider.activityWebsiteController.text,
      'activityNumber': provider.activityNumberController.text,
    };

    try {
      final RequestError requestError =
          await ownerProvider.updateData(ownerData);
      return requestError;
    } catch (e) {
      return RequestError.error;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Ottieni il provider e inizializza i controller con i dati esistenti
    final provider =
        Provider.of<EditOwnerProfileProvider>(context, listen: false);
    provider.initializeControllers(owner);

    return Scaffold(
      appBar: AppBar(
        title:  Text(AppTexts.profileOwner.editProfileOwner),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Consumer<EditOwnerProfileProvider>(
            builder: (context, provider, _) {
              return provider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            controller: provider.activityNameController,
                            decoration:  InputDecoration(
                              labelText: AppTexts.profileOwner.actName,
                              prefixIcon: Icon(Icons.business),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppTexts.profileOwner.actNameMsg;
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: provider.activityDescriptionController,
                            decoration:  InputDecoration(
                              labelText: AppTexts.profileOwner.actDesc,
                              prefixIcon: Icon(Icons.description),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: provider.activityLocationController,
                            decoration:  InputDecoration(
                              labelText: AppTexts.profileOwner.actAddress ,
                              prefixIcon: Icon(Icons.location_on),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppTexts.profileOwner.actAddressError;
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: provider.activityWebsiteController,
                            decoration:  InputDecoration(
                              labelText:  AppTexts.profileOwner.actWebSite,
                              prefixIcon: Icon(Icons.web),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: provider.activityNumberController,
                            decoration:  InputDecoration(
                              labelText:  AppTexts.profileOwner.actNumber,
                              prefixIcon: Icon(Icons.phone),
                            ),
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: () async {
                              provider.updateLoading(false);
                              final result =
                                  await _saveProfile(context, provider);
                              if (result == RequestError.done) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                   SnackBar(
                                    content:
                                        Text( AppTexts.profileOwner.actEditSuccMessage ),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                   SnackBar(
                                    content: Text(
                                        AppTexts.profileOwner.actAddressError),
                                  ),
                                );
                              }
                              provider.updateLoading(false);
                            },
                            child:  Text(AppTexts.controllers.save),
                          ),
                        ],
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }
}
