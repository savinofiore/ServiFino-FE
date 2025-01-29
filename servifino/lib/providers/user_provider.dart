import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/UserModel.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UserProvider with ChangeNotifier {
  UserModel? _user;
  //String url = ;
  final String _userCollection = dotenv.env['USER_COLLECTION'] ?? '';

  UserModel? get user => _user;


  // Funzione per popolare l'utente
  Future<void> fetchUserDataWithUid(String uid) async {
    try {

      // Ottieni i dati utente da Firestore
      DocumentSnapshot userDoc =
      await FirebaseFirestore.instance.collection(_userCollection).doc(uid).get();

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

      // Aggiorna l'istanza locale dell'utente
      _user = updatedUser;
      notifyListeners(); // Notifica i listener dell'aggiornamento
    } catch (e) {
      print("Errore durante l'aggiornamento dell'utente: $e");
      throw e; // Rilancia l'errore per gestirlo altrove
    }
  }




/*
  Future<int?> saveChanges(UserModel? user) async {

    isLoading = true;
    notifyListeners();
    try {
      // Dati da inviare al backend
      final Map<String, dynamic> requestBody = {
        'user': {
          'uid': user!.uid, // Assicurati di avere l'UID dell'utente
        },
        'displayName': displayNameController.text,
        'phoneNumber': phoneNumberController.text,
        'work': selectedWorkId,
        'isAvailable': isAvailable,
      };
      // Effettua la richiesta HTTP POST al backend
      final response = await http.post(
        Uri.parse(url), // Sostituisci con l'URL del tuo backend
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );


      return response.statusCode;
    } catch (error) {
      print('Error updating user: $error');
    } finally {
      isLoading = false;

      notifyListeners();
    }
  }*/











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