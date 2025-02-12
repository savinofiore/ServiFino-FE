import 'package:intl/intl.dart';

String formatDateTime(DateTime? dateTime) {
  // Converte la stringa in DateTime
  DateFormat formatter = DateFormat('dd-MM-yyyy HH:mm'); // Definisce il formato
  return formatter.format(dateTime!); // Restituisce la data formattata
}