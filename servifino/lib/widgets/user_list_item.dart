import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:servifino/models/ReservationModel.dart';
import 'package:servifino/models/UserModel.dart';
import 'package:servifino/providers/modelsProviders/owner_provider.dart';
import 'package:servifino/utils/app_texts.dart';
import 'package:servifino/utils/request_errors.dart';
import 'package:servifino/widgets/add_reservation_field.dart';
import 'package:servifino/widgets/show_confirmation_dialog.dart';
import 'package:servifino/widgets/show_message.dart';

class UserListItem extends StatelessWidget {
  final UserModel? user;

  const UserListItem({
    required this.user,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //bool _isLoading = false;
    DateTime? selectedDateTime;
    String? selectedMessage = '';
    TextEditingController _messageController = TextEditingController();
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
      child: Column(
        children: [
          Stack(
            children: [
              Padding(
                padding: EdgeInsets.all(12.0 * scaleFactor), // Scala il padding
                child: Row(
                  children: [
                    Icon(Icons.person,
                        size: 40.0 * scaleFactor,
                        color: Colors.blue), // Scala l'icona
                    SizedBox(width: 16.0 * scaleFactor), // Scala lo spazio
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user!.displayName,
                            style: TextStyle(
                              fontSize:
                                  18.0 * scaleFactor, // Scala il font size
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                              height: 4.0 * scaleFactor), // Scala lo spazio
                          Text(
                            user!.work ?? AppTexts.usrListTile.defaultWork,
                            style: TextStyle(
                              fontSize:
                                  14.0 * scaleFactor, // Scala il font size
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(
                            height: 4.0 * scaleFactor,
                          ), // Scala lo spazio
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Stato "Disponibile" in alto a destra
              Positioned(
                top: 8.0 * scaleFactor, // Scala la posizione
                right: 8.0 * scaleFactor, // Scala la posizione
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.0 * scaleFactor, // Scala il padding
                    vertical: 4.0 * scaleFactor, // Scala il padding
                  ),
                  decoration: BoxDecoration(
                    color: user!.isAvailable
                        ? Colors.green.withOpacity(0.2)
                        : Colors.red.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(
                        12.0 * scaleFactor), // Scala il bordo
                  ),
                  child: Text(
                    user!.isAvailable
                        ? AppTexts.usrListTile.available
                        : AppTexts.usrListTile.unavailable,
                    style: TextStyle(
                      fontSize: 12.0 * scaleFactor, // Scala il font size
                      color: user!.isAvailable ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // Pulsante "Prenota" in basso a destra
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  showConfirmationDialog(
                    context,
                    title: AppTexts.usrListTile.showDialogTitle,
                    message: AppTexts.usrListTile.showDialogMessage,
                    additionalWidget: AddReservationField(
                      updateSelected: (dateTime, message) {
                        selectedDateTime = dateTime;
                        selectedMessage = message;
                      },
                    ),
                    onConfirm: () async {


                      final ownerProvider =
                          Provider.of<OwnerProvider>(context, listen: false);
                      final Map<String, dynamic> reservationInfo = {
                        'user': user!.toMap(),
                        'owner': ownerProvider.data!.toMap(),
                        'reservationDate': selectedDateTime?.toIso8601String(),
                        'reservationStatus': 'waiting',
                        //'rating': 0
                        'message': selectedMessage
                      };
                      log(reservationInfo.toString());

                      try {
                        switch (await ownerProvider.addReservation(reservationInfo)) {
                          case RequestError.done:
                            ShowMessageWidget(
                                message: AppTexts.usrListTile.successMessage);
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
                    },
                  );
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
                  AppTexts.usrListTile.btnText,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0 * scaleFactor, // Scala il font size
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.0 * scaleFactor, // Scala il padding
              vertical: 8.0 * scaleFactor, // Scala il padding
            ),
          ),
        ],
      ),
    );
  }
}
