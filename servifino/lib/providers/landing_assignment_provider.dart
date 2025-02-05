import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LandingAssignmentProvider with ChangeNotifier {
  String? selectedWork;
  bool isAvailable = false; // Aggiungiamo uno stato per la disponibilità
  bool isLoading = false;
  String updateWorkerUrl = dotenv.env['UPDATE_WORKER_ENDPOINT'] ?? '';
  String addOwnerUrl = dotenv.env['ADD_OWNER_ENDPOINT'] ?? '';
  final Map<String, String> ownerDetails = {
    'activityName': '',
    'activityDescription': '',
    'activityLocation': '',
    'activityWebsite': '',
    'activityNumber': '',
  };

  void setSelectedWork(String? work) {
    selectedWork = work;
    notifyListeners();
  }

  void setAvailability(bool available) {
    isAvailable = available;
    notifyListeners();
  }

  void updateOwnerDetail(String key, String value) {
    ownerDetails[key] = value;
    notifyListeners();
  }

  void changeLoading(){
    isLoading = ! isLoading;
    notifyListeners();
  }

  /*Future<void> submitForm(UserModel? user) async {
    isLoading = true;
    notifyListeners();

    try {
      if (selectedWork == null) {
        throw Exception('No work selected');
      }

      /*
      if (selectedWork == 'owner') {
        // Prepare the data for the owner endpoint
        final ownerData = {
          'userUid': user!.uid,
          'activityName': ownerDetails['activityName'],
          'activityDescription': ownerDetails['activityDescription'],
          'activityLocation': ownerDetails['activityLocation'],
          'activityWebsite': ownerDetails['activityWebsite'],
          'activityNumber': ownerDetails['activityNumber'],
        };

        // Call the addOwner endpoint
        final response = await http.post(
          Uri.parse(addOwnerUrl),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(ownerData),
        );

        if (response.statusCode != 201) {
          throw Exception('Failed to add owner: ${response.body}');
        }
      } else {
        // Call the updateWorker endpoint
        final response = await http.post(
          Uri.parse(updateWorkerUrl),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'userId': user!.uid,
            'workId': selectedWork,
            'available': isAvailable,
          }),
        );

        if (response.statusCode != 200) {
          throw Exception('Failed to update work: ${response.body}');
        }

        */


      }
    } catch (e) {
      print('Error $e');
    } finally {
      isLoading = false;
      notifyListeners();

    }
  }*/
}
