import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:servifino/utils/app_texts.dart';

class UserModel {
  final String uid;
  final String email;
  late final String displayName;
  late final String? phoneNumber;
  final String? photoURL;
  final bool disabled;
  final bool assignment;
  late final String? work;
  final bool isOwner;
  late final bool isAvailable;
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
    this.work,
    required this.isOwner,
    required this.isAvailable,
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
      work: data['work'],
      isOwner: data['isOwner'],
      isAvailable: data['isAvailable'],
      //age: data['age'],
      //address: data['address'],
    );
  }

  /*
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] ?? '', // Fornisci un valore di default se null
      email: json['email'] ?? '', // Fornisci un valore di default se null
      displayName: json['displayName'] ?? '', // Fornisci un valore di default se null
      phoneNumber: json['phoneNumber'] ?? '', // Fornisci un valore di default se null
      photoURL: json['photoURL'] ?? AppTexts.utils.photoExampleUrl,
      disabled: json['disabled'] ?? false,
      assignment: json['assignment'] ?? false,
      work: json['work'] ?? '', // Fornisci un valore di default se null
      isOwner: json['isOwner'] ?? false,
      isAvailable: json['isAvailable'] ?? false, // Fornisci un valore di default se null
    );
  }*/

  UserModel updateLocally(
      String displayName, String phoneNumber, String? work, bool isAvailable) {
    return UserModel(
      uid: this.uid,
      email: this.email,
      displayName: displayName,
      phoneNumber: phoneNumber,
      photoURL: this.photoURL,
      disabled: this.disabled,
      assignment: this.assignment,
      work: work,
      isOwner: this.isOwner,
      isAvailable: isAvailable,
      //age: data['age'],
      //address: data['address'],
    );
  }

  // Converte l'oggetto UserModel in una mappa per Firestore
  /*
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'phoneNumber': phoneNumber,
      'photoURL': photoURL,
      'disabled': disabled,
      'assignment': assignment,
      'work': work,
      'isOwner': isOwner,
      'isAvailable': isAvailable
      //'age': age,
      //'address': address,
    };
  }
  */
}
