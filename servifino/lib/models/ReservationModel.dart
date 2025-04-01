import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:servifino/interfaces/ModelInterface.dart';
import 'package:servifino/models/OwnerModel.dart';
import 'package:servifino/models/UserModel.dart';
import 'package:servifino/utils/reservation_status.dart';


class ReservationModel implements ModelInterface {
  final String id;
  final UserModel? user;
  final OwnerModel? owner;
  final DateTime? reservationDate;
  final String reservationStatus;
  final int? rating;
  final String? message;

  ReservationModel({
    required this.id,
    required this.user,
    required this.owner,
    required this.reservationDate,
    required this.reservationStatus,
    this.rating,
    this.message,
  });

  factory ReservationModel.fromJson(Map<Object?, Object?> json) {
    return ReservationModel(
      id: json['id'] as String,
      //workerId: json['workerId'] as String,
      user: json['user'] != null
          ? UserModel.fromJson(json['user'] as Map<Object?, Object?>)
          : null,
      owner: json['owner'] != null
          ? OwnerModel.fromJson(json['owner'] as Map<Object?, Object?>)
          : null,
      reservationDate: json['bookDate'] != null
          ? DateTime.parse(json['bookDate'] as String)
          : null,
      reservationStatus: json['bookStatus'].toString(),
      rating: json['rating'] != null
          ? int.tryParse(json['rating'].toString()) ?? 0
          : null,
      message: json['message'] as String?,
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
      'user': user?.toMap(),
      'owner': owner?.toMap(),
      'reservationDate': reservationDate?.toIso8601String(), // Stringa compatibile
      'reservationStatus': reservationStatus.toString(),
      'rating': rating,
      'message': message,
    };
  }



  @override
  ModelInterface updateLocally(Map<String, dynamic> updates) {
    // TODO: implement updateLocally
    throw UnimplementedError();
  }
}