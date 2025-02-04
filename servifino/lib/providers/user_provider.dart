import 'dart:async';
import 'dart:developer';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:servifino/utils/request_errors.dart';
import '../models/UserModel.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;
  //String url = ;
  final String _userCollection = dotenv.env['USER_COLLECTION'] ?? '';

  UserModel? get user => _user;

  // Funzione per popolare l'utente
  Future<void> fetchUserDataWithUid(String uid) async {
    try {
      // Ottieni i dati utente da Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection(_userCollection)
          .doc(uid)
          .get();

      if (userDoc.exists) {
        _user = UserModel.fromFirestore(userDoc);
        notifyListeners(); // Notifica i listener quando lo stato cambia
      }
    } catch (e) {
      print("Errore nel recupero dei dati utente: $e");
    }
  }

  Future<void> fetchUserDataWithJson(Map<String, dynamic> userJson) async {
    try {
      // Creazione di un UserModel dal JSON ricevuto
      _user = UserModel.fromJson(userJson);
      notifyListeners();
    } catch (e) {
      print('Errore nel caricamento dei dati utente: $e');
    }
  }

  // Funzione per aggiornare l'utente
  /*Future<void> updateUser(UserModel updatedUser) async {
    try {
      String url = dotenv.env['UPDATE_USER_ENDPOINT'] ?? '';
      final Map<String, dynamic> requestBody = {
        'user': {
          'uid': user!.uid, // Assicurati di avere l'UID dell'utente
        },
        'displayName': updatedUser.displayName,
        'phoneNumber': updatedUser.phoneNumber,
        'work': updatedUser.work,
        'isAvailable': updatedUser.isAvailable,
      };

      final response = await http.post(
        Uri.parse(url), // Sostituisci con l'URL del tuo backend
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );
      _user = updatedUser;
      notifyListeners();
    } catch (e) {
      log("Errore durante l'aggiornamento dell'utente: $e");
      throw e;
    }
  }*/

  Future<RequestError> registerUser({
    required String email,
    required String password,
    required String displayName,
    required String phoneNumber,
    required String photoURL,
  }) async {
    try {
      HttpsCallable callable =
          FirebaseFunctions.instance.httpsCallable('createUser');
      await callable.call({
        "email": email,
        "password": password,
        "displayName": displayName,
        "phoneNumber": phoneNumber,
        "photoURL": photoURL
      });

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
    }
  }
}
