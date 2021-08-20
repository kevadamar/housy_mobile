import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  // state
  String _token;

  // get state
  String get token => _token;

  // set state
  void setToken(String token) {
    _token = token;
  }
}
