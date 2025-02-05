import 'dart:developer';

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
    try {
      HttpsCallable callable =
          FirebaseFunctions.instance.httpsCallable('addOrUpdateOwner');

      final res = await callable.call({
        "userUid": userUid,
        "activityName": activityName,
        "activityDescription": activityDescription,
        "activityLocation": activityLocation,
        "activityWebsite": activityWebsite,
        "activityNumber": activityNumber,
      });
      log(res.data.toString());
      _owner = _owner!.updateLocally(userUid, activityName, activityDescription,
          activityLocation, activityWebsite, activityNumber);
      return RequestError.done;
    } catch (e) {
      log('Error $e');
      return RequestError.error;
    } finally {
      notifyListeners();
    }
  }
}
