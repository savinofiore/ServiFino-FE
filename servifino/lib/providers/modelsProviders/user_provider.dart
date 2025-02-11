import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:servifino/interfaces/BaseProvider.dart';
import 'package:servifino/models/ReservationModel.dart';
import 'package:servifino/utils/request_errors.dart';
import '../../models/UserModel.dart';

class UserProvider extends BaseProvider<UserModel> {
  UserModel? _user;

  late List<ReservationModel> _reservationWaitingList = [];
  List<ReservationModel> _reservationExpiredList = [];

  get reservationWaitingList => _reservationWaitingList;

  @override
  UserModel? get data => _user;

  @override
  Future<void> fetchData(String uid) async {
    if (_user != null) return;
    try {
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (userDoc.exists) {
        _user = UserModel.fromFirestore(userDoc);
      }
    } catch (e) {
      print("Errore nel recupero dei dati utente: $e");
    } finally {
      notifyListeners();
    }
  }

  @override
  Future<RequestError> updateData(Map<String, dynamic> updates) async {
    try {
      HttpsCallable callable = FirebaseFunctions.instance
          .httpsCallableFromUrl('https://updateuser-sap7hrqoga-uc.a.run.app');

      await callable.call(updates);
      _user = _user!.updateLocally(updates);
      notifyListeners();
      return RequestError.done;
    } catch (e) {
      log('Error $e');
      return RequestError.error;
    }
  }

  Future<RequestError> registerUser(Map<String, dynamic> userData) async {
    try {
      HttpsCallable callable = FirebaseFunctions.instance
          .httpsCallableFromUrl('https://createuser-sap7hrqoga-uc.a.run.app');
      await callable.call(userData);
      return RequestError.done;
    } catch (e) {
      log('Error $e');
      return RequestError.error;
    } finally {
      notifyListeners();
    }
  }

  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      String uid = userCredential.user!.uid;
      return uid;
    } catch (e) {
      log("Errore nel login: $e");
      return null;
    }
  }

  void logout() async {
    try {
      // Effettua il logout da Firebase
      await FirebaseAuth.instance.signOut();
      // Resetta i dati utente locali
      _user = null;
      notifyListeners();
    } catch (error) {
      print('Errore durante il logout: $error');
    } finally {
      notifyListeners();
    }
  }

  Future<void> fetchReservations() async {
    try {
      // Verifica che l'userId non sia nullo
      if (_user == null || _user!.uid.isEmpty) {
        throw Exception('UserId non valido');
      }
      // Ottieni il riferimento alla funzione Firebase
      HttpsCallable callable = FirebaseFunctions.instance.httpsCallableFromUrl(
        'http://127.0.0.1:5001/servifino/us-central1/getReservationsWaitingByUserId',
      );

      final response = await callable.call({
          'userId': _user!.uid,
      });
      response.data.map((reservation) {
          log('Single: $reservation');
          _reservationWaitingList.add(ReservationModel.fromJson(reservation));
        }).toList();

    } catch (e) {
      log('Errore durante il recupero delle prenotazioni: $e');
      throw Exception('Errore durante il recupero delle prenotazioni: $e');
    }
  }


}
