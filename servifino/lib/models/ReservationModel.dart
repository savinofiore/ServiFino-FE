import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:servifino/interfaces/ModelInterface.dart';
import 'package:servifino/models/OwnerModel.dart';
import 'package:servifino/utils/reservation_status.dart';


class ReservationModel implements ModelInterface {
  final String id;
  final String workerId;
  final OwnerModel? owner;
  final DateTime? reservationDate;
  final String reservationStatus;
  final int? rating;
  final String? additionalInformations;

  ReservationModel({
    required this.id,
    required this.workerId,
    required this.owner,
    required this.reservationDate,
    required this.reservationStatus,
    this.rating,
    this.additionalInformations,
  });

  factory ReservationModel.fromJson(Map<String, dynamic> json) {
    return ReservationModel(
      id: json['id'] as String,
      workerId: json['workerId'] as String,
      owner: json['owner'] != null
          ? OwnerModel.fromJson(json['owner'] as Map<String, dynamic>)
          : null,
      reservationDate: json['bookDate'] != null
          ? DateTime.parse(json['bookDate'] as String)
          : null,
      reservationStatus: json['bookStatus'],
      rating: json['rating'] != null
          ? int.tryParse(json['rating'].toString()) ?? 0
          : null,
      additionalInformations: json['additionalInformations'] as String?,
    );
  }

  // Metodo per convertire ReservationStatus da stringa a enum
 /* static ReservationStatus _parseReservationStatus(String status) {
    switch (status) {
      case 'waiting':
        return ReservationStatus.waiting;
      case 'approved':
        return ReservationStatus.approved;
      case 'rejected':
        return ReservationStatus.rejected;
      case 'evaluated':
        return ReservationStatus.evaluated;
      default:
        throw Exception('Stato della prenotazione non valido: $status');
    }
  }*/

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'workerId': workerId,
      'owner': owner?.toMap(),
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