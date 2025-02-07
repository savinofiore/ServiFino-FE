/*import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:servifino/models/OwnerModel.dart';
import 'package:servifino/utils/request_errors.dart';

class OwnerProvider with ChangeNotifier {
  OwnerModel? _owner;
  final String _ownerCollection = dotenv.env['OWNER_COLLECTION'] ?? '';
  OwnerModel? get owner => _owner;

  Future<void> fetchOwnerDataWithUid(String uid) async {
    try {
      // Ottieni i dati utente da Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection(_ownerCollection)
          .doc(uid)
          .get();

      if (userDoc.exists) {
        _owner = OwnerModel.fromFirestore(userDoc);
        notifyListeners(); // Notifica i listener quando lo stato cambia
      }
    } catch (e) {
      print("Errore nel recupero dei dati owner: $e");
    }
  }

  Future<RequestError> addOwner({
    required String userUid,
    required String activityName,
    required String? activityDescription,
    required String activityLocation,
    required String? activityWebsite,
    required String? activityNumber,
  }) async {

    Map<String, dynamic> updates = {
      "userUid": userUid,
      "activityName": activityName,
      "activityDescription": activityDescription,
      "activityLocation": activityLocation,
      "activityWebsite": activityWebsite,
      "activityNumber": activityNumber,
    };

    try {
      HttpsCallable callable = FirebaseFunctions.instance.httpsCallableFromUrl('https://us-central1-servifino.cloudfunctions.net/addOrUpdateOwner');

      final res = await callable.call(updates);
      log(res.data.toString());
      _owner = _owner!.updateLocally(updates);
      return RequestError.done;
    } catch (e) {
      log('Error $e');
      return RequestError.error;
    } finally {
      notifyListeners();
    }
  }
}
*/

import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:servifino/interfaces/BaseProvider.dart';
import 'package:servifino/models/OwnerModel.dart';
import 'package:servifino/utils/request_errors.dart';

class OwnerProvider extends BaseProvider<OwnerModel> {
  OwnerModel? _owner;
  @override
  OwnerModel? get data => _owner;

  @override
  Future<void> fetchData(String uid) async {
    try {
      DocumentSnapshot ownerDoc = await FirebaseFirestore.instance
          .collection('owners')
          .doc(uid)
          .get();

      if (ownerDoc.exists) {
        _owner = OwnerModel.fromFirestore(ownerDoc);
        notifyListeners();
      }
    } catch (e) {
      print("Errore nel recupero dei dati owner: $e");
    }
  }

  @override
  Future<RequestError> updateData(Map<String, dynamic> updates) async {
    try {
      HttpsCallable callable = FirebaseFunctions.instance.httpsCallableFromUrl(
          'https://us-central1-servifino.cloudfunctions.net/addOrUpdateOwner');

      await callable.call(updates);
      _owner = _owner!.updateLocally(updates);
      notifyListeners();
      return RequestError.done;
    } catch (e) {
      log('Error $e');
      return RequestError.error;
    }
  }
}
