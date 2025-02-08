import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:servifino/interfaces/BaseProvider.dart';
import 'package:servifino/models/OwnerModel.dart';
import 'package:servifino/models/ReservationModel.dart';
import 'package:servifino/models/UserModel.dart';
import 'package:servifino/utils/request_errors.dart';

class OwnerProvider extends BaseProvider<OwnerModel> {
  OwnerModel? _owner;
  List<UserModel?> _usersToBook = []; // Lista di UserModel

  List<UserModel?> get usersToBook => _usersToBook;

  @override
  OwnerModel? get data => _owner;

  @override
  Future<void> fetchData(String uid) async {
    // if(_owner != null) return;
    try {
      DocumentSnapshot ownerDoc =
          await FirebaseFirestore.instance.collection('owners').doc(uid).get();

      if (ownerDoc.exists) {
        _owner = OwnerModel.fromFirestore(ownerDoc);
      }
    } catch (e) {
      print("Errore nel recupero dei dati owner: $e");
    } finally {
      notifyListeners();
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

  Future<void> fetchAvailableNonOwnerUsers() async {
    if (_usersToBook.isNotEmpty) return;
    try {
      // Ottieni il riferimento alla funzione Firebase
      HttpsCallable callable = FirebaseFunctions.instance.httpsCallableFromUrl(
        'https://us-central1-servifino.cloudfunctions.net/getNonOwnerUsers',
      );
      // Chiama la funzione Firebase
      final response = await callable.call();
      if (response.data != null && response.data['users'] != null) {
        final List<dynamic> usersData = response.data['users'];
        _usersToBook =
            usersData.map((user) => UserModel.fromJson(user)).toList();
       // log(response.data['users'].toString());
      } else {
        log('nessun dato trovato');
      }
    } catch (e) {
      log('Errore recupero $e');
    } finally {
      notifyListeners();
    }
  }

  Future<RequestError> addReservation(
      Map<String, dynamic> reservationInfo) async {

    try {
      HttpsCallable callable = FirebaseFunctions.instance.httpsCallableFromUrl(
        //  'https://us-central1-servifino.cloudfunctions.net/addOrUpdateOwner'
        'http://127.0.0.1:5001/servifino/us-central1/addReservation'
        );
      await callable.call(reservationInfo);
      //_owner = _owner!.updateLocally(updates);
      notifyListeners();
      return RequestError.done;
    } catch (e) {
      log('Error $e');
      return RequestError.error;
    }
  }
}
