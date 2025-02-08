import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:servifino/interfaces/ModelInterface.dart';
import 'package:servifino/models/OwnerModel.dart';
import 'package:servifino/utils/reservation_status.dart';

class ReservationModel implements ModelInterface {
  final String workerId;
  final OwnerModel? owner;
  final DateTime? reservationDate;
  final ReservationStatus reservationStatus;
  final int? rating;
  final String? additionalInformations;

  ReservationModel({
    required this.workerId,
    required this.owner,
    required this.reservationDate,
    required this.reservationStatus,
    this.rating,
    this.additionalInformations,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'workerId': workerId,
      'owner': owner!.toMap(),
     //'reservationDate': reservationDate,
      'reservationDate': reservationDate?.toIso8601String(), // Stringa compatibile
      'reservationStatus': reservationStatus.toString(),
      'rating': rating,
      'additionalInformations': additionalInformations,
    };
  }

  @override
  ModelInterface updateLocally(Map<String, dynamic> updates) {
    // TODO: implement updateLocally
    throw UnimplementedError();
  }
}

enum ReservationStatus {
  waiting,
  approved,
  rejected,
  evaluated
}
