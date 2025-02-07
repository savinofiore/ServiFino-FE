import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:servifino/interfaces/ModelInterface.dart';

class OwnerModel implements ModelInterface {
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

  @override
  Map<String, dynamic> toMap() {
    return {
      'userUid': userUid,
      'activityName': activityName,
      'activityDescription': activityDescription,
      'activityLocation': activityLocation,
      'activityWebsite': activityWebsite,
      'activityNumber': activityNumber,
    };
  }

  @override
  OwnerModel updateLocally(Map<String, dynamic> updates) {
    return OwnerModel(
      userUid: updates['userUid'] ?? userUid,
      activityName: updates['activityName'] ?? activityName,
      activityDescription: updates['activityDescription'] ?? activityDescription,
      activityLocation: updates['activityLocation'] ?? activityLocation,
      activityWebsite: updates['activityWebsite'] ?? activityWebsite,
      activityNumber: updates['activityNumber'] ?? activityNumber,
    );
  }
}
