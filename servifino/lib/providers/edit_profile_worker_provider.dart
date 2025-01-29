import 'package:flutter/material.dart';
import '../models/UserModel.dart';
import '../models/WorksModel.dart';

class ProfileEditProvider with ChangeNotifier {
  final TextEditingController displayNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  String? selectedWorkId;
  bool isAvailable = false;
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

  Future<void> saveChanges() async {
    // Implementa la logica di salvataggio qui
    print('Saving changes:');
    print('Display Name: ${displayNameController.text}');
    print('Email: ${emailController.text}');
    print('Phone: ${phoneNumberController.text}');
    print('Work ID: $selectedWorkId');
    print('Available: $isAvailable');
  }

  @override
  void dispose() {
    displayNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }
}
