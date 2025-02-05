import 'package:cloud_firestore/cloud_firestore.dart';

class OwnerModel {
  final String userUid;
  final String activityName;
  final String? activityDescription;
  final String activityLocation;
  final String? activityWebsite;
  final String? activityNumber;

  OwnerModel({
    required this.userUid,
    required this.activityName,
    this.activityDescription,
    required this.activityLocation,
    this.activityWebsite,
    this.activityNumber,
  });

  factory OwnerModel.fromFirestore(DocumentSnapshot doc) {
    var data = doc.data() as Map<String, dynamic>;
    return OwnerModel(
      userUid: data['userUid'],
      activityName: data['activityName'],
      activityDescription: data['activityDescription'],
      activityLocation: data['activityLocation'],
      activityWebsite: data['activityWebsite'],
      activityNumber: data['activityNumber'],
    );
  }

  OwnerModel updateLocally(
      String newUserUid,
      newActivityName,
      newActivityLocation,
      String? newActivityDescription,
      newActivityWebsite,
      newActivityNumber) {
    return OwnerModel(
        userUid: newUserUid,
        activityName: newActivityName,
        activityLocation: newActivityLocation,
        activityDescription: newActivityDescription ?? activityDescription,
        activityWebsite: newActivityWebsite ?? activityWebsite,
        activityNumber: newActivityNumber ?? activityNumber);
  }
}
