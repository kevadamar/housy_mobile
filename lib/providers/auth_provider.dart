import 'dart:io';

import 'package:dev_mobile/models/user_model.dart';
import 'package:dev_mobile/services/services.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  // state
  String _token;
  UserModel _user;
  bool _isProcessing = false;
  File _imageFile;

  // get state
  String get token => _token;
  bool get isProcessing => _isProcessing;
  UserModel get user => _user;
  File get imageFile => _imageFile;

  // set state
  void setToken(String token) {
    _token = token;
  }

  void resetUser() => _user = null;

  void setImageFile(File image) {
    _imageFile = image;
    notifyListeners();
  }

  void resetImageFile() => _imageFile = null;

  void getUser() async {
    setIsProcessing(true);

    final response = await Services.instance.getUserByToken(_token);

    _user = UserModel.fromJson(response['data']);
    print(_user.imagePofile);
    setIsProcessing(false);
  }

  void setIsProcessing(bool status) {
    _isProcessing = status;
    notifyListeners();
  }
}
