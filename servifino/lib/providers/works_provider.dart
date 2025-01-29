import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:servifino/models/WorksModel.dart';


class WorksProvider with ChangeNotifier {
  List<WorkModel> _worksList = [];
  bool _isLoading = false;

  List<WorkModel> get worksList => _worksList;
  bool get isLoading => _isLoading;

  // Metodo per caricare i lavori dalla collezione Firestore
  Future<void> fetchWorks() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Recupera i documenti dalla collezione 'works'
      CollectionReference worksRef = FirebaseFirestore.instance.collection('works');
      QuerySnapshot worksSnapshot = await worksRef.get();

      // Mappa i documenti a oggetti WorksModel
      _worksList = worksSnapshot.docs
          .map((doc) => WorkModel.fromFirestore(doc))
          .toList();

    } catch (e) {
      print('Errore nel recupero dei dati: $e');
      _worksList = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

