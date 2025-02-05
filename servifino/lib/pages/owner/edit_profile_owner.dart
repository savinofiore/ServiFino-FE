import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servifino/models/OwnerModel.dart';
import 'package:servifino/models/UserModel.dart';
import 'package:servifino/providers/edit_profile_owner_provider.dart';
import 'package:servifino/providers/owner_provider.dart';
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

    try {
      final RequestError requestError = await ownerProvider.addOwner(
        userUid: user!.uid,
        activityName: provider.activityNameController.text,
        activityDescription: provider.activityDescriptionController.text,
        activityLocation: provider.activityLocationController.text,
        activityWebsite: provider.activityWebsiteController.text,
        activityNumber: provider.activityNumberController.text,
      );
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
        title: const Text('Modifica Profilo Proprietario'),
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
                            decoration: const InputDecoration(
                              labelText: 'Nome Attività',
                              prefixIcon: Icon(Icons.business),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Il nome dell\'attività è obbligatorio';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: provider.activityDescriptionController,
                            decoration: const InputDecoration(
                              labelText: 'Descrizione Attività',
                              prefixIcon: Icon(Icons.description),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: provider.activityLocationController,
                            decoration: const InputDecoration(
                              labelText: 'Indirizzo Attività',
                              prefixIcon: Icon(Icons.location_on),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'L\'indirizzo dell\'attività è obbligatorio';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: provider.activityWebsiteController,
                            decoration: const InputDecoration(
                              labelText: 'Sito Web',
                              prefixIcon: Icon(Icons.web),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: provider.activityNumberController,
                            decoration: const InputDecoration(
                              labelText: 'Numero di Telefono',
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
                                  const SnackBar(
                                    content:
                                        Text('Profilo salvato con successo!'),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Errore durante il salvataggio del profilo.'),
                                  ),
                                );
                              }
                              provider.updateLoading(false);
                            },
                            child: const Text('Salva'),
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
