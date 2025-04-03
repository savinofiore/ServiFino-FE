import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:servifino/interfaces/BaseProvider.dart';
import 'package:servifino/models/OwnerModel.dart';
import 'package:servifino/models/ReservationModel.dart';
import 'package:servifino/models/UserModel.dart';
import 'package:servifino/utils/app_endpoints.dart';
import 'package:servifino/utils/request_errors.dart';

class OwnerProvider extends BaseProvider<OwnerModel> {
  OwnerModel? _owner;
  late List<ReservationModel> _reservationsList = [];
  List<UserModel?> _usersToBook = []; // Lista di UserModel

  List<UserModel?> get usersToBook => _usersToBook;
  List<ReservationModel> get reservationsList => _reservationsList;

  @override
  OwnerModel? get data => _owner;

  @override
  Future<void> fetchData(String uid) async {
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
      HttpsCallable callable = FirebaseFunctions.instance
          .httpsCallableFromUrl(AppEndpoints.owner.addOrUpdateOwner);
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
      HttpsCallable callable = FirebaseFunctions.instance
          .httpsCallableFromUrl(AppEndpoints.owner.getNonOwnerUsers);
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
      HttpsCallable callable = FirebaseFunctions.instance
          .httpsCallableFromUrl(AppEndpoints.owner.addReservation);
      await callable.call(reservationInfo);
      return RequestError.done;
    } catch (e) {
      log('Error $e');
      return RequestError.error;
    } finally {
      fetchReservations();
      notifyListeners();
    }
  }

  Future<void> fetchReservations() async {
    try {
      // Verifica che l'userId non sia nullo
      if (_owner == null || _owner!.userUid.isEmpty) {
        throw Exception('UserId non valido');
      }
      // Ottieni il riferimento alla funzione Firebase
      HttpsCallable callable = FirebaseFunctions.instance
          .httpsCallableFromUrl(AppEndpoints.owner.getReservationsSent);

      final response = await callable.call({
        'userId': _owner!.userUid,
      });

      // Verifica se la risposta contiene dati
      if (response.data == null || response.data.isEmpty) {
        throw Exception('Nessuna prenotazione trovata');
      }
      response.data.map((reservation) {
        _reservationsList.add(ReservationModel.fromJson(reservation));
      }).toList();
    } catch (e) {
      log('Errore durante il recupero delle prenotazioni: $e');
      throw Exception('Errore durante il recupero delle prenotazioni: $e');
    } finally {
      //rimuove eventuali duplicati
      _removeDuplicates();
      notifyListeners();
    }
  }

  //funzione per rimuovere duplicati
  void _removeDuplicates() {
    final seenIds = <String>{}; // Set per memorizzare gli ID già visti
    _reservationsList.retainWhere((reservation) => seenIds.add(reservation.id));
  }
}
