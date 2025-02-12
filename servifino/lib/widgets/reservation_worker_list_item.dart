import 'package:flutter/material.dart';
import 'package:servifino/models/ReservationModel.dart';
import 'package:servifino/utils/app_texts.dart';

class ReservationWorkerListItem extends StatelessWidget {
  final ReservationModel reservation;

  ReservationWorkerListItem({super.key, required this.reservation});

  @override
  Widget build(BuildContext context) {
    //bool _isLoading = false;
    DateTime? selectedDateTime;

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
            Positioned(
              top: 8.0 * scaleFactor, // Scala la posizione
              right: 8.0 * scaleFactor, // Scala la posizione
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.0 * scaleFactor, // Scala il padding
                  vertical: 4.0 * scaleFactor, // Scala il padding
                ),
                decoration: BoxDecoration(
                  color: reservation.reservationStatus == 'waiting'
                      ? Colors.yellow.withOpacity(0.2)
                      : Colors.green.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(
                      12.0 * scaleFactor), // Scala il bordo
                ),
                child: Text(
                  reservation.reservationStatus == 'waiting'
                      ? AppTexts.usrListTile.available
                      : AppTexts.usrListTile.unavailable,
                  style: TextStyle(
                    fontSize: 12.0 * scaleFactor, // Scala il font size
                    color: reservation.reservationStatus == 'waiting' ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            // Contenuto principale della card
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
                        reservation.owner!.activityName,
                        style: TextStyle(
                          fontSize: 18.0 * scaleFactor, // Scala il font size
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4.0 * scaleFactor), // Scala lo spazio
                      Text(
                        reservation.owner!.activityLocation,
                        style: TextStyle(
                          fontSize: 14.0 * scaleFactor, // Scala il font size
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
                height: 8.0 * scaleFactor), // Spazio tra contenuto e pulsanti
            // Riga con i pulsanti "Accetta", "Rifiuta", "Info"
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Pulsante "Accetta"
                ElevatedButton(
                  onPressed: () {
                    // Azione per il pulsante "Accetta"
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          20.0 * scaleFactor), // Scala il bordo
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.0 * scaleFactor, // Scala il padding
                      vertical: 8.0 * scaleFactor, // Scala il padding
                    ),
                  ),
                  child: Text(
                    AppTexts.resListItem.done,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0 * scaleFactor, // Scala il font size
                    ),
                  ),
                ),
                // Pulsante "Rifiuta"
                ElevatedButton(
                  onPressed: () {
                    // Azione per il pulsante "Rifiuta"
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          20.0 * scaleFactor), // Scala il bordo
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.0 * scaleFactor, // Scala il padding
                      vertical: 8.0 * scaleFactor, // Scala il padding
                    ),
                  ),
                  child: Text(
                    AppTexts.resListItem.reject,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0 * scaleFactor, // Scala il font size
                    ),
                  ),
                ),
                // Pulsante "Info"
                ElevatedButton(
                  onPressed: () {
                    // Azione per il pulsante "Info"
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          20.0 * scaleFactor), // Scala il bordo
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.0 * scaleFactor, // Scala il padding
                      vertical: 8.0 * scaleFactor, // Scala il padding
                    ),
                  ),
                  child: Text(
                    AppTexts.resListItem.info,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0 * scaleFactor, // Scala il font size
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
