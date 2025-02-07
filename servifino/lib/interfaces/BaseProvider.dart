import 'package:flutter/material.dart';

abstract class BaseProvider<T> with ChangeNotifier {
  T? get data; // L'elemento gestito dal provider

  Future<void> fetchData(String uid);
  Future<void> updateData(Map<String, dynamic> updates);
}
