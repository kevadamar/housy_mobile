import 'dart:convert';

import 'package:dev_mobile/utils/api.dart';
import 'package:http/http.dart' as http;

class BookingServices {
  Api api = Api();

  Future<dynamic> getBookings(String token) async {
    try {
      final requestHeaders = {'Authorization': 'Bearer $token'};
      final responseData = await http.get(
          Uri.parse(
            api.baseUrl + '/bookings',
          ),
          headers: requestHeaders);

      final data = jsonDecode(responseData.body);

      return data;
    } catch (e) {
      print('$e err');
      throw 'error from server';
    }
  }
}
