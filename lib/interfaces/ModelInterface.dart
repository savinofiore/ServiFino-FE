import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ModelInterface {
  factory ModelInterface.fromFirestore(DocumentSnapshot doc) => throw UnimplementedError();
  factory ModelInterface.fromJson(Map<String, dynamic> json) => throw UnimplementedError();

  Map<String, dynamic> toMap();
  ModelInterface updateLocally(Map<String, dynamic> updates);
}
