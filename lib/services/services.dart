import 'dart:io';

import 'package:dev_mobile/services/auth_services.dart';
import 'package:dev_mobile/services/booking_services.dart';
import 'package:dev_mobile/services/city_services.dart';
import 'package:dev_mobile/services/history_services.dart';
import 'package:dev_mobile/services/house_services.dart';
import 'package:flutter/material.dart';

class Services {
  final _authServices = AuthServices();
  final _houseServices = HouseServices();
  final _bookingServices = BookingServices();
  final _historyServices = HistoryServices();
  final _cityServices = CityServices();

  static Services instance = Services();

  Future<dynamic> signin(String email, String password) =>
      _authServices.signin(email, password);
  Future<dynamic> signup(
      String fullname,
      String username,
      String email,
      String password,
      String listAs,
      String gender,
      String phoneNumber,
      String address) {
    String roleId = '2';

    if (listAs.toLowerCase() == 'owner') {
      roleId = '1';
    }

    return _authServices.signup(fullname, username, email, password, roleId,
        gender, phoneNumber, address);
  }

  Future<dynamic> updateProfile(BuildContext context, String fullname,
      String username, String phoneNumber, String address) {
    return _authServices.updateProfile(
        context, fullname, username, phoneNumber, address);
  }

  Future<dynamic> getUserByToken(String token) =>
      _authServices.getUserByToken(token);

  Future<dynamic> getHousesByToken(String token) =>
      _houseServices.getHousesByToken(token);

  Future<dynamic> getCities() => _cityServices.getCities();

  Future<dynamic> getHouses() => _houseServices.getHouses();

  Future<dynamic> getBookings(String token) =>
      _bookingServices.getBookings(token);

  Future<dynamic> postBooking(String houseId, DateTime checkin,
          DateTime checkout, int total, String token) =>
      _bookingServices.postBooking(houseId, checkin, checkout, total, token);

  Future<dynamic> getHistory(String token) =>
      _historyServices.getHistorys(token);

  Future<dynamic> updateStatus(int orderId, int status, String token) =>
      _historyServices.updateStatus(orderId, status, token);

  Future<dynamic> orderHouse(File file, String houseId, String bookingId,
          DateTime checkin, DateTime checkout, int total, String token) =>
      _historyServices.orderHouse(
          file, houseId, bookingId, checkin, checkout, total, token);

  Future<dynamic> getHousesDisekitar(String city) =>
      _houseServices.getHousesDisekitar(city);

  Future<dynamic> getHousesByFilterCombination(String city, String price) =>
      _houseServices.getHousesByFilterCombination(city, price);

  Future<dynamic> addHouse(BuildContext context, String name, int price,
          String address, int area, String description) =>
      _houseServices.addHouse(context, name, price, address, area, description);

  Future<dynamic> updateHouse(BuildContext context, String name, int price,
          String address, int area, String description, int houseId) =>
      _houseServices.updateHouse(
          context, name, price, address, area, description, houseId);

  Future<dynamic> deleteHouse(BuildContext context, int houseId) =>
      _houseServices.deleteHouse(context, houseId);

  Future<dynamic> deleteBooking(BuildContext context, int houseId) =>
      _bookingServices.deleteBooking(context, houseId);
}
