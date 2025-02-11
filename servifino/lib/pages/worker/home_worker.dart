import 'package:flutter/material.dart';
import 'package:servifino/models/ReservationModel.dart';
import 'package:servifino/models/UserModel.dart';
import 'package:servifino/models/WorksModel.dart';
import 'package:servifino/widgets/reservation_list_item.dart';


class HomeWorker extends StatelessWidget {
  late UserModel? user;
  late List<WorkModel>? works;
  late List<ReservationModel> reservations;

  HomeWorker({
    super.key,
    required this.user,
    required this.works,
    required this.reservations,
  });

  @override
  Widget build(BuildContext context) {
    //funzione per rimuovere duplicati
    List<ReservationModel> _removeDuplicates(
        List<ReservationModel> reservations) {
      final seenIds = <String>{}; // Set per memorizzare gli ID già visti
      reservations.retainWhere((reservation) => seenIds.add(reservation.id));
      return reservations;
    }

    return reservations.isEmpty
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(
            itemCount: _removeDuplicates(reservations).length,
            itemBuilder: (context, index) {
              final ReservationModel reservation = reservations[index];
              return ReservationListItem(reservation: reservation,);
            },
          );
  }
}
