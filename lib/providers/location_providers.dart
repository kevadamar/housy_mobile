import 'package:dev_mobile/utils/injector.dart';
import 'package:dev_mobile/utils/location_utils.dart';
import 'package:flutter/material.dart';

class LocationProvider extends ChangeNotifier {
  //* ----------------------------
  //* This is side for property data
  //* ----------------------------

  //* Location Address
  String _address;
  String get address => _address;
  String _city;
  String get city => _city;

  //* Location Coordinate
  double _latitude;
  double get latitude => _latitude;
  double _longitude;
  double get longitude => _longitude;

  //* Dependency Injection
  LocationUtils locationUtils = locator<LocationUtils>();

  //* ----------------------------
  //* Function field
  //* ----------------------------

  /// Function to load location from GPS and address
  void loadLocation() async {
    await locationUtils.getLocation();

    _address = await locationUtils.getAddress();

    print(_address);

    _latitude = locationUtils.latitude;
    _longitude = locationUtils.longitude;
    _city = locationUtils.city;

    notifyListeners();
  }
}
