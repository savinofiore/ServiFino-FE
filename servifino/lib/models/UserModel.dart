import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String email;
  final String displayName;
  final bool disabled;
  late final String? work;
  final bool isOwner;
  late final bool isAvailable;

  UserModel({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.disabled,
    this.work,
    required this.isOwner,
    required this.isAvailable,
  });

  // Crea un oggetto UserModel da un documento Firestore
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

  UserModel updateLocally(String newDisplayName, String? newWork, bool newIsAvailable) {
    return UserModel(
      uid: uid,
      email: email,
      displayName: newDisplayName,
      disabled: disabled,
      work: newWork,
      isOwner: isOwner,
      isAvailable: newIsAvailable,
    );
  }

}
