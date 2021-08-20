import 'package:dev_mobile/services/auth_services.dart';
import 'package:dev_mobile/services/booking_services.dart';
import 'package:dev_mobile/services/house_services.dart';

class Services {
  final _authServices = AuthServices();
  final _houseServices = HouseServices();
  final _bookingServices = BookingServices();

  static Services instance = Services();

  Future<dynamic> signin(String email, String password) =>
      _authServices.signin(email, password);
  Future<dynamic> getHouses() => _houseServices.getHouses();
  Future<dynamic> getBookings(String token) =>
      _bookingServices.getBookings(token);
  Future<dynamic> getHousesDisekitar(String city) =>
      _houseServices.getHousesDisekitar(city);
}
