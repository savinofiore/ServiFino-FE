import 'package:flutter/material.dart';
import 'package:servifino/models/UserModel.dart';

class UserListItem extends StatelessWidget {
  final UserModel? user;
  final VoidCallback onBookPressed;

  const UserListItem({
    required this.user,
    required this.onBookPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Ottieni le dimensioni dello schermo
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Definisci dimensioni di base per mobile e limiti per desktop
    final baseWidth = 400.0; // Larghezza di riferimento per dispositivi mobili
    final maxWidth = 600.0; // Larghezza massima per evitare elementi troppo grandi su desktop

    // Calcola le dimensioni in modo adattivo
    final responsiveWidth = screenWidth > maxWidth ? maxWidth : screenWidth;
    final scaleFactor = responsiveWidth / baseWidth;

    return Card(
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: screenWidth * 0.04, // 4% della larghezza dello schermo
      ),
      elevation: 2,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(12.0 * scaleFactor), // Scala il padding
            child: Row(
              children: [
                Icon(Icons.person, size: 40.0 * scaleFactor, color: Colors.blue), // Scala l'icona
                SizedBox(width: 16.0 * scaleFactor), // Scala lo spazio
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user!.displayName,
                        style: TextStyle(
                          fontSize: 18.0 * scaleFactor, // Scala il font size
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4.0 * scaleFactor), // Scala lo spazio
                      Text(
                        user!.work ?? 'non specificato',
                        style: TextStyle(
                          fontSize: 14.0 * scaleFactor, // Scala il font size
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 4.0 * scaleFactor), // Scala lo spazio
                      Text(
                        'Valutazione',
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
                color: user!.isAvailable ? Colors.green.withOpacity(0.2) : Colors.red.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12.0 * scaleFactor), // Scala il bordo
              ),
              child: Text(
                user!.isAvailable ? 'Disponibile' : 'Non Disponibile',
                style: TextStyle(
                  fontSize: 12.0 * scaleFactor, // Scala il font size
                  color: user!.isAvailable ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // Pulsante "Prenota" in basso a destra
          Positioned(
            bottom: 8.0 * scaleFactor, // Scala la posizione
            right: 8.0 * scaleFactor, // Scala la posizione
            child: ElevatedButton(
              onPressed: onBookPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0 * scaleFactor), // Scala il bordo
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0 * scaleFactor, // Scala il padding
                  vertical: 8.0 * scaleFactor, // Scala il padding
                ),
              ),
              child: Text(
                'Prenota',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0 * scaleFactor, // Scala il font size
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}