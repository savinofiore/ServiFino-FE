import 'package:flutter/material.dart';
import 'package:servifino/models/ReservationModel.dart';
import 'package:servifino/models/UserModel.dart';
import 'package:servifino/models/WorksModel.dart';
import 'package:servifino/widgets/reservation_worker_list_item.dart';

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
    return reservations.isEmpty
        ? const Center(
            child: Text('Nessuna prenotazione in sospeso'),
          )
        : ListView.builder(
            itemCount: reservations.length,
            itemBuilder: (context, index) {
              final ReservationModel reservation = reservations[index];
              return ReservationWorkerListItem(
                reservation: reservation,
              );
            },
          );
  }
}
