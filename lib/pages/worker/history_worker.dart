import 'package:flutter/material.dart';
import 'package:servifino/models/ReservationModel.dart';
import 'package:servifino/utils/app_texts.dart';
import 'package:servifino/widgets/reservationModified_worker_list_item.dart';

import '../../models/UserModel.dart';
import '../../models/WorksModel.dart';

class HistoryWorker extends StatelessWidget {
  late UserModel? user;
  late List<WorkModel>? works;
  late List<ReservationModel> reservations;
  HistoryWorker({
    super.key,
    required this.user,
    required this.works,
    required this.reservations,
  });

  @override
  Widget build(BuildContext context) {
    return reservations.isEmpty
        ?  Center(
      child: Text(AppTexts.historyOwner.emptyList),
    )
        : ListView.builder(
      itemCount: reservations.length,
      itemBuilder: (context, index) {
        final ReservationModel reservation = reservations[index];
        return ReservationModifiedWorkerListItem(
          works: works,
          reservation: reservation,
        );
      },
    );
  }
}
