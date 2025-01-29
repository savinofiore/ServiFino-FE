import 'package:cloud_firestore/cloud_firestore.dart';

// Modello per un singolo lavoro
class WorkModel {
  final String description;
  final String name;
  final String id;

  WorkModel({
    required this.description,
    required this.name,
    required this.id,
  });

  // Creazione di un oggetto WorksModel da Firestore
  factory WorkModel.fromFirestore(DocumentSnapshot doc) {
    var data = doc.data() as Map<String, dynamic>;

    return WorkModel(
      id: doc.id,
      description: data['description'] ?? '', // Gestione di valori nulli
      name: data['name'] ?? '',               // Gestione di valori nulli
    );
  }

  // Converte l'oggetto WorksModel in una mappa per Firestore
  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'name': name,
    };
  }
}

// Modello per la collezione di lavori
class WorksCollectionModel {
  final List<WorkModel> worksList;

  WorksCollectionModel({
    required this.worksList,
  });

  // Metodo asincrono per recuperare la collezione di lavori
  static Future<WorksCollectionModel> fetchFromFirestore() async {
    try {
      // Ottieni la collezione di lavori da Firestore
      CollectionReference worksRef = FirebaseFirestore.instance.collection('works');

      // Recupera i documenti dalla collezione 'works'
      QuerySnapshot worksSnapshot = await worksRef.get();

      // Mappa i documenti a oggetti WorksModel
      List<WorkModel> worksList = worksSnapshot.docs
          .map((doc) => WorkModel.fromFirestore(doc))
          .toList();

      // Restituisci un oggetto WorksCollectionModel
      return WorksCollectionModel(worksList: worksList);
    } catch (e) {
      print('Errore nel recupero dei dati: $e');
      return WorksCollectionModel(worksList: []);
    }
  }
}
