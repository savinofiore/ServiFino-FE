/*import 'package:cloud_firestore/cloud_firestore.dart';
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
      CollectionReference worksRef =
          FirebaseFirestore.instance.collection('works');
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
*/
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:servifino/interfaces/BaseProvider.dart';
import 'package:servifino/models/WorksModel.dart';

class WorksProvider extends BaseProvider<List<WorkModel>> {
  List<WorkModel> _worksList = [];
   bool _isLoading = false;

  @override
  List<WorkModel> get data => _worksList;

  bool get isLoading => _isLoading;

  @override
  Future<void> fetchData(String uid) async {
    _isLoading = true;
    notifyListeners();
    if(_worksList.isNotEmpty) return;
    try {
      CollectionReference worksRef =
      FirebaseFirestore.instance.collection('works');
      QuerySnapshot worksSnapshot = await worksRef.get();

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

  @override
  Future<void> updateData(Map<String, dynamic> updates) async {
    // Se serve un'update, si può implementare qui.
  }
}
