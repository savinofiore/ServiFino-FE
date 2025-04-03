import 'package:flutter/material.dart';

import '../utils/app_texts.dart';

void showConfirmationDialog(BuildContext context, {
  required String title,
  required String message,
  required VoidCallback onConfirm,
  final Widget? additionalWidget,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Container(child:Column(
          mainAxisSize: MainAxisSize.min,
          children: [Text(message), if(additionalWidget != null) additionalWidget],
        )),
        actions: <Widget>[
          //additionalWidget ?? Container(),
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