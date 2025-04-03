import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io' show Platform;

class ShowMessageWidget extends StatelessWidget {
  final String message;

  const ShowMessageWidget({super.key, required this.message});

  void showMessage(BuildContext context) {
    if (Platform.isAndroid || Platform.isIOS) {
      Fluttertoast.showToast(
        msg: message,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => showMessage(context),
      child: const Text("Show Message"),
    );
  }
}
