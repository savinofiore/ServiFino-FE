import 'package:flutter/material.dart';

abstract class BaseProvider<T> with ChangeNotifier {
  T? get data; // Model gestito dal provider

  Future<void> fetchData(String uid);
  Future<void> updateData(Map<String, dynamic> updates);
}
