import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:servifino/providers/user_provider.dart';
import '../models/UserModel.dart';
import '../models/WorksModel.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
/*
class ProfileEditProvider with ChangeNotifier {
  final TextEditingController displayNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  String? selectedWorkId;
  bool isAvailable = false;
  bool isLoading = false;
  final List<WorkModel>? works;

  ProfileEditProvider({
    required UserModel? user,
    required this.works,
  }) {
    _initializeFromUser(user);
  }

  void _initializeFromUser(UserModel? user) {
    displayNameController.text = user!.displayName;
    emailController.text = user!.email;
    phoneNumberController.text = user!.phoneNumber ?? '';
    selectedWorkId = user!.work;
    isAvailable = user!.isAvailable;
  }

  void updateSelectedWork(String workId) {
    selectedWorkId = workId;
    notifyListeners();
  }

  void updateAvailability(bool available) {
    isAvailable = available;
    notifyListeners();
  }

  Future<int?> saveChanges(UserModel? user) async {
    String url = dotenv.env['UPDATE_USER_ENDPOINT'] ?? '';
    isLoading = true;
    notifyListeners();
    try {
      // Dati da inviare al backend
      final Map<String, dynamic> requestBody = {
        'user': {
          'uid': user!.uid, // Assicurati di avere l'UID dell'utente
        },
        'displayName': displayNameController.text,
        'phoneNumber': phoneNumberController.text,
        'work': selectedWorkId,
        'isAvailable': isAvailable,
      };
      // Effettua la richiesta HTTP POST al backend
      final response = await http.post(
        Uri.parse(url), // Sostituisci con l'URL del tuo backend
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );


      return response.statusCode;
    } catch (error) {
      print('Error updating user: $error');
    } finally {
      isLoading = false;

      notifyListeners();
    }
  }

  Future<void> _updateUser(UserModel? user) async {


  }

  @override
  void dispose() {
    displayNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }
}
*/


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

      // Aggiorna l'utente nel UserProvider

      await userProvider.updateUser(updatedUser);

      isLoading = false;
      notifyListeners();
      return 200; // Success
    } catch (e) {
      isLoading = false;
      notifyListeners();
      print("Errore durante il salvataggio: $e");
      return 500; // Internal server error
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