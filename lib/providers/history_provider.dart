import 'package:dev_mobile/models/history_model.dart';
import 'package:flutter/material.dart';

class HistoryProvider extends ChangeNotifier {
  /// state
  List<HistoryModel> _data = [];

  bool _isProcessing = true;

  // getter state
  List<HistoryModel> get data => _data;

  bool get isProcessing => _isProcessing;

  // set state
  void setData(List<HistoryModel> res) {
    _data = res;
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
}
