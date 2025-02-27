/*import 'package:flutter/material.dart';
import 'package:servifino/providers/modelsProviders/user_provider.dart';
import '../../models/UserModel.dart';
import '../../models/WorksModel.dart';

class ProfileEditProvider with ChangeNotifier {
  final TextEditingController displayNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  String? selectedWorkId;
  bool isAvailable = false;
  bool isLoading = false;

  final List<WorkModel>? works;
  final UserModel? user;

  ProfileEditProvider({required this.works, required this.user}) {
    // Inizializza i controller con i dati dell'utente
    if (user != null) {
      displayNameController.text = user!.displayName;
      emailController.text = user!.email;
      //phoneNumberController.text = user!.phoneNumber ?? '';
      selectedWorkId = user!.work;
      isAvailable = user!.isAvailable;
    }
  }

  // Aggiorna il lavoro selezionato
  void updateSelectedWork(String workId) {
    selectedWorkId = workId;
    notifyListeners();
  }

  // Aggiorna la disponibilità
  void updateAvailability(bool available) {
    isAvailable = available;
    notifyListeners();
  }
  // Aggiorna la disponibilità
  void updateLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  // Salva le modifiche
  Future<int> saveChanges(UserModel? user, UserProvider userProvider) async {
    if (user == null) return 400; // Bad request

    isLoading = true;
    notifyListeners();

    try {
      // Crea una nuova istanza di UserModel con i dati aggiornati
      UserModel updatedUser = UserModel(
        uid: user.uid,
        email: emailController.text,
        displayName: displayNameController.text,
        //phoneNumber: phoneNumberController.text,
        //photoURL: user.photoURL,
        disabled: user.disabled,
        //assignment: user.assignment,
        work: selectedWorkId,
        isOwner: user.isOwner,
        isAvailable: isAvailable,
      );

      //await userProvider.updateUser(updatedUser);

      return 200; // Success
    } catch (e) {
      print("Errore durante il salvataggio: $e");
      return 500; // Internal server error
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    displayNameController.dispose();
    emailController.dispose();
    super.dispose();
  }
}
*/

import 'package:flutter/material.dart';
import 'package:servifino/interfaces/BaseUIProvider.dart';
import 'package:servifino/providers/modelsProviders/user_provider.dart';
import '../../models/UserModel.dart';
import '../../models/WorksModel.dart';

class ProfileEditProvider extends BaseUIProvider {
  final TextEditingController displayNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  String? selectedWorkId;
  bool isAvailable = false;

  final List<WorkModel>? works;
  final UserModel? user;

  ProfileEditProvider({required this.works, required this.user}) {
    if (user != null) {
      displayNameController.text = user!.displayName;
      emailController.text = user!.email;
      selectedWorkId = user!.work;
      isAvailable = user!.isAvailable;
    }
  }

  void updateSelectedWork(String workId) {
    selectedWorkId = workId;
    notifyListeners();
  }

  void updateAvailability(bool available) {
    isAvailable = available;
    notifyListeners();
  }

  Future<int> saveChanges(UserModel? user, UserProvider userProvider) async {
    if (user == null) return 400;

    updateLoading(true);
    try {
      UserModel updatedUser = UserModel(
        uid: user.uid,
        email: emailController.text,
        displayName: displayNameController.text,
        disabled: user.disabled,
        work: selectedWorkId,
        isOwner: user.isOwner,
        isAvailable: isAvailable,
      );

      return 200;
    } catch (e) {
      print("Errore durante il salvataggio: $e");
      return 500;
    } finally {
      updateLoading(false);
    }
  }

  @override
  void disposeControllers() {
    displayNameController.dispose();
    emailController.dispose();
  }
}
