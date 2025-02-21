import 'package:flutter/material.dart';
import 'package:servifino/models/ReservationModel.dart';
import 'package:servifino/models/WorksModel.dart';
import 'package:servifino/utils/app_texts.dart';
import 'package:servifino/utils/formatDateTime.dart';

class ReservationModifiedWorkerListItem extends StatelessWidget {
  final ReservationModel reservation;
  final List<WorkModel>? works;

  ReservationModifiedWorkerListItem({
    super.key,
    required this.reservation,
    required this.works,
  });

  @override
  Widget build(BuildContext context) {
    // Ottieni le dimensioni dello schermo
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Definisci dimensioni di base per mobile e limiti per desktop
    const baseWidth = 400.0; // Larghezza di riferimento per dispositivi mobili
    const maxWidth =
        600.0; // Larghezza massima per evitare elementi troppo grandi su desktop

    // Calcola le dimensioni in modo adattivo
    final responsiveWidth = screenWidth > maxWidth ? maxWidth : screenWidth;
    final scaleFactor = responsiveWidth / baseWidth;

    return Card(
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: screenWidth * 0.04, // 4% della larghezza dello schermo
      ),
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(12.0 * scaleFactor), // Scala il padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.calendar_month,
                    size: 40.0 * scaleFactor,
                    color: Colors.blue), // Scala l'icona
                SizedBox(width: 16.0 * scaleFactor), // Scala lo spazio
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${reservation.owner!.activityName} - ${works?.firstWhere((work) => work.id.toString() == reservation.user!.work, orElse: () => WorkModel(id: '', name: '', description: '')).name}',
                        style: TextStyle(
                          fontSize: 18.0 * scaleFactor, // Scala il font size
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      //SizedBox(height: 4.0 * scaleFactor), // Scala lo spazio
                      Text(
                        //reservation.reservationDate!.toIso8601String(),
                        '${reservation.owner!.activityLocation}, ${formatDateTime(reservation.reservationDate)}',
                        style: TextStyle(
                          fontSize: 14.0 * scaleFactor, // Scala il font size
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        //reservation.reservationDate!.toIso8601String(),
                        'Informazioni aggiuntive',
                        style: TextStyle(
                          fontSize: 14.0 * scaleFactor, // Scala il font size
                          color: Colors.grey[600],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        reservation.message.toString(),
                        style: TextStyle(
                          fontSize: 14.0 * scaleFactor, // Scala il font size
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        //reservation.reservationDate!.toIso8601String(),
                        'Contatti',
                        style: TextStyle(
                          fontSize: 12.0 * scaleFactor, // Scala il font size
                          color: Colors.grey[600],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        //reservation.reservationDate!.toIso8601String(),
                        '${reservation.owner!.activityNumber}',
                        style: TextStyle(
                          fontSize: 12.0 * scaleFactor, // Scala il font size
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        //reservation.reservationDate!.toIso8601String(),
                        '${reservation.owner!.activityWebsite}',
                        style: TextStyle(
                          fontSize: 12.0 * scaleFactor, // Scala il font size
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0 * scaleFactor),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.0 * scaleFactor, // Scala il padding
                    vertical: 4.0 * scaleFactor, // Scala il padding
                  ),
                  decoration: BoxDecoration(
                    color: reservation.reservationStatus == 'waiting'
                        ? Colors.yellowAccent.withOpacity(0.2)
                        : reservation.reservationStatus == 'accepted'
                            ? Colors.green.withOpacity(0.2)
                            : Colors.red.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(
                        12.0 * scaleFactor), // Scala il bordo
                  ),
                  child: Text(
                    reservation.reservationStatus == 'waiting'
                        ? AppTexts.historyOwner.waitingStatus
                        : reservation.reservationStatus == 'accepted'
                            ? AppTexts.historyOwner.acceptedStatus
                            : AppTexts.historyOwner.rejectedStatus,
                    style: TextStyle(
                      fontSize: 12.0 * scaleFactor, // Scala il font size
                      color: reservation.reservationStatus == 'waiting'
                          ? Colors.yellowAccent
                          : reservation.reservationStatus == 'accepted'
                              ? Colors.green
                              : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
