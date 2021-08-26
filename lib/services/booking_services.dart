import 'dart:convert';

import 'package:dev_mobile/providers/auth_provider.dart';
import 'package:dev_mobile/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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

  Future<dynamic> postBooking(String houseId, DateTime checkin,
      DateTime checkout, int total, String token) async {
    try {
      final f = new DateFormat('MM-dd-yyyy');

      final requestHeaders = {'Authorization': 'Bearer $token'};

      final responseData = await http.post(
          Uri.parse(
            api.baseUrl + '/booking',
          ),
          body: {
            'checkin': f.format(checkin),
            'checkout': f.format(checkout),
            'total': '$total',
            'house_id': houseId,
            'status': '1',
          },
          headers: requestHeaders);

      final data = jsonDecode(responseData.body);

      return data;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> deleteBooking(BuildContext context, int bookingId) async {
    try {
      final token = Provider.of<AuthProvider>(context, listen: false).token;

      final requestHeaders = {'Authorization': 'Bearer $token'};

      final responseData = await http.delete(
        Uri.parse(api.baseUrl + '/booking/' + bookingId.toString()),
        headers: requestHeaders,
      );

      final data = jsonDecode(responseData.body);

      return data;
    } catch (e) {
      print('$e err');
      throw 'error from server';
    }
  }
}
