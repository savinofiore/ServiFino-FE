import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:servifino/interfaces/ModelInterface.dart';

class WorkModel implements ModelInterface {
  final String description;
  final String name;
  final String id;

  WorkModel({
    required this.description,
    required this.name,
    required this.id,
  });

  factory WorkModel.fromFirestore(DocumentSnapshot doc) {
    var data = doc.data() as Map<String, dynamic>;
    return WorkModel(
      id: doc.id,
      description: data['description'] ?? '',
      name: data['name'] ?? '',
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'name': name,
    };
  }

  @override
  WorkModel updateLocally(Map<String, dynamic> updates) {
    return WorkModel(
      id: id,
      description: updates['description'] ?? description,
      name: updates['name'] ?? name,
    );
  }

}
