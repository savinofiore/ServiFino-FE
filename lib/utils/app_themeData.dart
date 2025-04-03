import 'package:flutter/material.dart';

class MyTheme {
  static const Color primaryColor = Color(0xFFD4B773); // Colore principale
  static const Color scaffoldBackgroundColor = Colors.white; // Sfondo dell'app
  static const Color appBarBackgroundColor =
      Color(0xFFD4B773); // Colore della barra superiore
  static const Color appBarTitleColor =
      Colors.white; // Colore del titolo della barra superiore
  static const Color textColor = Colors.black; // Colore del testo
  static const Color buttonColor = Color(0xFFD4B773); // Colore dei pulsanti

  static MyBottomNavigationBarTheme bottomNavigationBarTheme =
      MyBottomNavigationBarTheme(); // Tema per la bottom navigation bar
}

// classe per il bottom navigation bat
class MyBottomNavigationBarTheme {
  final Color backgroundColor = Color(0xFFD4B773); // Colore della bottom bar
  final Color selectedItemColor =
      Colors.white; // Colore dell'elemento selezionato
  final Color unselectedItemColor =
      Color(0xFF343434); // Colore degli elementi non selezionati
}
