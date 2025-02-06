import 'package:flutter/material.dart';

import '../utils/app_texts.dart';

void showConfirmationDialog(BuildContext context, {
  required String title,
  required String message,
  required VoidCallback onConfirm,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Chiudi il dialog
            },
            child: Text(AppTexts.controllers.cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Chiudi il dialog
              onConfirm(); // Esegui la funzione di conferma
            },
            child: Text(AppTexts.controllers.confirm, style: const TextStyle(color: Colors.red)),
          ),
        ],
      );
    },
  );
}