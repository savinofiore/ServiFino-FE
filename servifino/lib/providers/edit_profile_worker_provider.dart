import 'package:flutter/material.dart';
import 'package:servifino/providers/user_provider.dart';
import '../models/UserModel.dart';
import '../models/WorksModel.dart';

class ProfileEditProvider with ChangeNotifier {
  final TextEditingController displayNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
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
      phoneNumberController.text = user!.phoneNumber ?? '';
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
        phoneNumber: phoneNumberController.text,
        photoURL: user.photoURL,
        disabled: user.disabled,
        assignment: user.assignment,
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
    phoneNumberController.dispose();
    super.dispose();
  }
}
