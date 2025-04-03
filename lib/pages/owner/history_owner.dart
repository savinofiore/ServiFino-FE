import 'package:flutter/material.dart';
import 'package:servifino/models/ReservationModel.dart';
import 'package:servifino/models/WorksModel.dart';
import 'package:servifino/utils/app_texts.dart';
import 'package:servifino/widgets/reservation_owner_list_item.dart';

class HistoryOwner extends StatelessWidget {
  late List<ReservationModel> reservations;
  late List<WorkModel>? works;
   HistoryOwner({super.key, required this.reservations, required this.works});

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
        return ReservationOwnerListItem(
          works: works,
          reservation: reservation,
        );
      },
    );
  }
}
