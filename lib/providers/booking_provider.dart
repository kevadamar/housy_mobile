import 'dart:io';

import 'package:dev_mobile/models/booking_model.dart';
import 'package:flutter/material.dart';

class BookingProvider extends ChangeNotifier {
  /// state
  List<BookingModel> _data = [];
  String _selectedImg;
  bool _isProcessing = false;
  File _imageFile;

  // getter state
  List<BookingModel> get data => _data;
  String get selectedImg => _selectedImg;
  bool get isProcessing => _isProcessing;
  File get imageFile => _imageFile;

  // set state
  void setData(List<BookingModel> res) {
    _data = res;
    notifyListeners();
  }

  void setImageFile(File image) {
    _imageFile = image;
    notifyListeners();
  }

  void setIsProcessing(bool status) {
    _isProcessing = status;
    notifyListeners();
  }

  void setIsProcessingTrue() {
    _isProcessing = true;
    notifyListeners();
  }

  void setSelecetImg(String img) {
    _selectedImg = img;
    notifyListeners();
  }

  void setIniSelectedImg(String img) => _selectedImg = img;

  void resetImageFile() => _imageFile = null;
}
