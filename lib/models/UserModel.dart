import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:servifino/interfaces/ModelInterface.dart';
import 'package:servifino/models/WorksModel.dart';

class UserModel implements ModelInterface {
  final String uid;
  final String email;
  final String displayName;
  final bool disabled;
  final String? work;
  final bool isOwner;
  final bool isAvailable;


  UserModel({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.disabled,
    this.work,
    required this.isOwner,
    required this.isAvailable,
  });

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    var data = doc.data() as Map<String, dynamic>;
    return UserModel(
      uid: data['uid'],
      email: data['email'],
      displayName: data['displayName'],
      disabled: data['disabled'],
      work: data['work'],
      isOwner: data['isOwner'],
      isAvailable: data['isAvailable'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'disabled': disabled,
      'work': work,
      'isOwner': isOwner,
      'isAvailable': isAvailable,
    };
  }

  @override
  UserModel updateLocally(Map<String, dynamic> updates) {
    return UserModel(
      uid: updates['uid'] ?? uid,
      email: updates['email'] ?? email,
      displayName: updates['displayName'] ?? displayName,
      disabled: updates['disabled'] ?? disabled,
      work: updates['work'] ?? work,
      isOwner: updates['isOwner'] ?? isOwner,
      isAvailable: updates['isAvailable'] ?? isAvailable,
    );
  }

  // Metodo per convertire JSON in UserModel
  factory UserModel.fromJson(Map<Object?, Object?> json) {
    return UserModel(
      uid: (json['uid'] ?? '').toString(),
      email: (json['email'] ?? '').toString(),
      displayName: (json['displayName'] ?? '').toString(),
      isAvailable: (json['isAvailable'] ?? false) as bool,
      isOwner: (json['isOwner'] ?? false) as bool,
      disabled:( json['disabled'] ?? false) as bool,
      work: (json['work'] ?? null).toString()
    );
  }
}
