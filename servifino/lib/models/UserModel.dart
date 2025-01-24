import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String email;
  final String displayName;
  final String? phoneNumber;
  final String? photoURL;
  final bool disabled;
  final bool assignment;
  //final int? age; // Nuovo campo
  //final String? address; // Nuovo campo

  UserModel({
    required this.uid,
    required this.email,
    required this.displayName,
    this.phoneNumber,
    this.photoURL,
    required this.disabled,
    required this.assignment,
    //this.age,
    //this.address,
  });

  // Crea un oggetto UserModel da un documento Firestore
  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    var data = doc.data() as Map<String, dynamic>;
    return UserModel(
      uid: data['uid'],
      email: data['email'],
      displayName: data['displayName'],
      phoneNumber: data['phoneNumber'],
      photoURL: data['photoURL'],
      disabled: data['disabled'],
      assignment: data['assignment'],
      //age: data['age'],
      //address: data['address'],
    );
  }

  // Converte l'oggetto UserModel in una mappa per Firestore
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'phoneNumber': phoneNumber,
      'photoURL': photoURL,
      'disabled': disabled,
      'assignment': assignment,
      //'age': age,
      //'address': address,
    };
  }
}
