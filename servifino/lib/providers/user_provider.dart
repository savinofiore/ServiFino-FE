import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/UserModel.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  // Funzione per popolare l'utente
  Future<void> fetchUserDataWithUid(String uid) async {
    try {
      // Ottieni i dati utente da Firestore
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

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

  // Funzione per settare l'utente manualmente
  void setUser(UserModel userModel) {
    _user = userModel;
    notifyListeners();
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
