import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/UserModel.dart';
import 'package:http/http.dart' as http;

class UserProvider with ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  // Funzione per popolare l'utente
  Future<void> fetchUserData(String uid) async {
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

  Future<bool> registerUser(
      {required String email,
      required String password,
      required String displayName,
      required String phoneNumber,
      required String photoURL}) async {
    const String url = 'http://127.0.0.1:5001/servifino/us-central1/api/users/create'; // Cambia con il tuo endpoint

    try {
      // Creazione del corpo della richiesta
      final body = json.encode({
        'email': email,
        'password': password,
        'displayName': displayName,
        'phoneNumber': phoneNumber,
        'photoURL': 'https://example.com/photo.jpg',
        'disabled': false,
        'assignment': false,
      });

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        print('Registrazione avvenuta con successo!');
        return true;
      } else {
        print('Errore nella registrazione: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Errore durante la chiamata all\'API: $e');
      return false;
    }
  }
}
