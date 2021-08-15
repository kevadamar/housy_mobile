import 'package:flutter/material.dart';

class BookNowProvider extends ChangeNotifier {
  /// state
  DateTime _checkin;
  DateTime _checkout;
  DateTime _initCheckinDate;
  DateTime _initCheckoutDate;
  int _priceHouse = 0;
  int _totalPrice = 0;
  int _houseId;

  // getter state
  int get totalPrice => _totalPrice;
  int get houseId => _houseId;

  DateTime get checkin => _checkin;
  DateTime get checkout => _checkout;

  DateTime get initCheckinDate {
    var datenow = DateTime.now().add(Duration(days: 1));
    _initCheckinDate = DateTime(datenow.year, datenow.month, datenow.day);
    return _initCheckinDate;
  }

  DateTime get initCheckoutDate {
    _initCheckoutDate = DateTime(
        _checkin.add(Duration(days: 1)).year,
        _checkin.add(Duration(days: 1)).month,
        _checkin.add(Duration(days: 1)).day);
    return _initCheckoutDate;
  }

  // set state
  void setCheckin(DateTime date) {
    _checkin = date;
    _initCheckoutDate = _checkin.add(Duration(days: 1));
    if (_checkin.day >= checkout.day) {
      _checkout = initCheckoutDate;
    }
    Duration duration = checkout.difference(_checkin);
    _totalPrice = _priceHouse * (duration.inDays);

    notifyListeners();
  }

  void setCheckout(DateTime date) {
    _checkout = date;
    Duration duration = _checkout.difference(_checkin);
    _totalPrice = _priceHouse * (duration.inDays);

    notifyListeners();
  }

  void setBookNowProvider(int price, int houseId) {
    _priceHouse = price;
    _totalPrice = price;
    _houseId = houseId;

    var datenow = DateTime.now().add(Duration(days: 1));

    _checkin = DateTime(datenow.year, datenow.month, datenow.day);
    _checkout = _checkin.add(Duration(days: 1));
  }
}
