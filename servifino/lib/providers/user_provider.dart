import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/UserModel.dart';
/*
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
  void setUser(UserModel user, String selectedWorkId, bool isAvailable) {
    _user = _user?.copyWith(
      displayName: user.displayName,
      phoneNumber: user.phoneNumber,
      work: selectedWorkId,
      isAvailable: isAvailable,
    );
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
*/

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

  // Funzione per aggiornare l'utente
  Future<void> updateUser(UserModel updatedUser) async {
    try {
      // Aggiorna l'utente su Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(updatedUser.uid)
          .update(updatedUser.toMap());

      // Aggiorna l'istanza locale dell'utente
      _user = updatedUser;
      notifyListeners(); // Notifica i listener dell'aggiornamento
    } catch (e) {
      print("Errore durante l'aggiornamento dell'utente: $e");
      throw e; // Rilancia l'errore per gestirlo altrove
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