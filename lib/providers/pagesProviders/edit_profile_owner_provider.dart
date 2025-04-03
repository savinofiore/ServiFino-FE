/*import 'package:flutter/material.dart';
import 'package:servifino/models/OwnerModel.dart';

class EditOwnerProfileProvider with ChangeNotifier {
  final OwnerModel? owner;

  // Controller per i campi del form
  final TextEditingController activityNameController = TextEditingController();
  final TextEditingController activityDescriptionController = TextEditingController();
  final TextEditingController activityLocationController = TextEditingController();
  final TextEditingController activityWebsiteController = TextEditingController();
  final TextEditingController activityNumberController = TextEditingController();

  // Stato di caricamento
  bool _isLoading = false;

  EditOwnerProfileProvider({required this.owner});
  bool get isLoading => _isLoading;

  // Metodo per aggiornare lo stato di caricamento
  void updateLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // Metodo per inizializzare i controller con i dati esistenti (se presenti)
  void initializeControllers(OwnerModel? owner) {
    if (owner != null) {
      activityNameController.text = owner.activityName;
      activityDescriptionController.text = owner.activityDescription ?? '';
      activityLocationController.text = owner.activityLocation;
      activityWebsiteController.text = owner.activityWebsite ?? '';
      activityNumberController.text = owner.activityNumber ?? '';
    }
  }

  // Metodo per pulire i controller quando non sono più necessari
  void disposeControllers() {
    activityNameController.dispose();
    activityDescriptionController.dispose();
    activityLocationController.dispose();
    activityWebsiteController.dispose();
    activityNumberController.dispose();
  }
}*/

import 'package:flutter/material.dart';
import 'package:servifino/interfaces/BaseUIProvider.dart';
import 'package:servifino/models/OwnerModel.dart';

class EditOwnerProfileProvider extends BaseUIProvider {
  final OwnerModel? owner;

  final TextEditingController activityNameController = TextEditingController();
  final TextEditingController activityDescriptionController = TextEditingController();
  final TextEditingController activityLocationController = TextEditingController();
  final TextEditingController activityWebsiteController = TextEditingController();
  final TextEditingController activityNumberController = TextEditingController();

  EditOwnerProfileProvider({required this.owner}) {
    initializeControllers(owner);
  }

  void initializeControllers(OwnerModel? owner) {
    if (owner != null) {
      activityNameController.text = owner.activityName;
      activityDescriptionController.text = owner.activityDescription ?? '';
      activityLocationController.text = owner.activityLocation;
      activityWebsiteController.text = owner.activityWebsite ?? '';
      activityNumberController.text = owner.activityNumber ?? '';
    }
  }

  @override
  void disposeControllers() {
    activityNameController.dispose();
    activityDescriptionController.dispose();
    activityLocationController.dispose();
    activityWebsiteController.dispose();
    activityNumberController.dispose();
  }
}
