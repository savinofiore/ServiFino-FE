import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servifino/models/ReservationModel.dart';
import 'package:servifino/providers/modelsProviders/user_provider.dart';
import 'package:servifino/utils/app_endpoints.dart';
import 'package:servifino/utils/app_texts.dart';
import 'package:servifino/utils/formatDateTime.dart';
import 'package:servifino/utils/request_errors.dart';
import 'package:servifino/widgets/show_confirmation_dialog.dart';
import 'package:servifino/widgets/show_message.dart';

class ReservationWorkerListItem extends StatelessWidget {
  final ReservationModel reservation;

  ReservationWorkerListItem({super.key, required this.reservation});

  @override
  Widget build(BuildContext context) {
    Future<void> _updateStatus(String newStatus) async {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final Map<String, dynamic> reservationInfo = {
        'reservationId': reservation.id,
        'reservationStatus': newStatus
      };
      try {
        switch (await userProvider.editReservationStatus(reservationInfo)) {
          case RequestError.done:
            ShowMessageWidget(message: AppTexts.usrListTile.successMessage);
            break;
          case RequestError.error:
            ShowMessageWidget(
              message: AppTexts.usrListTile.errorMessage,
            );
            break;
        }
      } catch (e) {
        ShowMessageWidget(
          message: AppTexts.usrListTile.errorMessage,
        );
        // log('Error $e');
      }
    }

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
                        reservation.owner!.activityLocation +
                            ', ' +
                            formatDateTime(reservation.reservationDate),
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

            reservation.reservationStatus == 'waiting'
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Pulsante "Accetta"
                      ElevatedButton(
                        onPressed: () {
                          showConfirmationDialog(
                            context,
                            title: AppTexts.usrListTile.showDialogTitle,
                            message: AppTexts.usrListTile.showDialogMessage,
                            onConfirm: () {
                              _updateStatus('accepted');
                            },
                          );
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
                          showConfirmationDialog(
                            context,
                            title: AppTexts.usrListTile.showDialogTitle,
                            message: AppTexts.usrListTile.showDialogMessage,
                            onConfirm: () {
                              _updateStatus('rejected');
                            },
                          );
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
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(reservation.reservationStatus == 'accepted'
                          ? AppTexts.historyOwner.acceptedStatus
                          : AppTexts.historyOwner.rejectedStatus)
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
