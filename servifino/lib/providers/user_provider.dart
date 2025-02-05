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
  final String _userCollection = dotenv.env['USER_COLLECTION'] ?? '';

  UserModel? get user => _user;

  /*
  * Fetch model session
  * */
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
  /*
  * Authentication session
  * */
  /*
  * Register user
  * */
  Future<RequestError> registerUser({
    required String email,
    required String password,
    required String displayName,
    required String phoneNumber,
    required String photoURL,
    required bool isOwner,
  }) async {
    try {
      HttpsCallable callable =
          FirebaseFunctions.instance.httpsCallable('createUser');
      await callable.call({
        "email": email,
        "password": password,
        "displayName": displayName,
        "phoneNumber": phoneNumber,
        "photoURL": photoURL,
        "isOwner": isOwner
      });

      return RequestError.done;
    } catch (e) {
      log('Error $e');
      return RequestError.error;
    } finally {
      notifyListeners();
    }
  }
  /*
  * Login user
  * */
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
/*
* Logout user
* */
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
  /*
   * Update work session
   * */
  Future<RequestError> updateUser(
      {required String userId,
      required String displayName,
      required String phoneNumber,
      required String? work,
      required bool isAvailable}) async {
    try {
      HttpsCallable callable =
          FirebaseFunctions.instance.httpsCallable('updateUser');
      log('Trying..');

      await callable.call(<String, dynamic>{
        "userId": userId,
        "displayName": displayName,
        "phoneNumber": phoneNumber,
        "work": work,
        "isAvailable": isAvailable
      });
      _user = _user!.updateLocally(displayName, phoneNumber, work, isAvailable);
      notifyListeners();
      return RequestError.done;
    } catch (e) {
      log('Error $e');
      return RequestError.error;
    }
  }
}
