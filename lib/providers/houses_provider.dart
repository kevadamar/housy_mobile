import 'package:flutter/material.dart';

class HousesProvider extends ChangeNotifier {
  /// response data
  Map<Object, dynamic> _data = {};
  Map<Object, dynamic> get data => _data;
}
