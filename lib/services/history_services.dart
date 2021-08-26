import 'dart:convert';
import 'dart:io';

import 'package:dev_mobile/utils/api.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class HistoryServices {
  Api api = Api();

  Future<dynamic> getHistorys(String token) async {
    try {
      final requestHeaders = {'Authorization': 'Bearer $token'};
      final responseData = await http.get(
          Uri.parse(
            api.baseUrl + '/orders',
          ),
          headers: requestHeaders);

      final data = jsonDecode(responseData.body);

      return data;
    } catch (e) {
      print('$e err');
      throw 'error from server';
    }
  }

  Future<dynamic> updateStatus(int orderId, int status, String token) async {
    try {
      final requestHeaders = {'Authorization': 'Bearer $token'};

      final responseData = await http.patch(
          Uri.parse(api.baseUrl + '/order/' + orderId.toString() + '/status'),
          headers: requestHeaders,
          body: {"status": status.toString()});

      final data = jsonDecode(responseData.body);

      print('data $data');

      return data;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> orderHouse(File file, String houseId, String bookingId,
      DateTime checkin, DateTime checkout, int total, String token) async {
    try {
      final f = new DateFormat('MM-dd-yyyy');

      final requestHeaders = {'Authorization': 'Bearer $token'};

      var request =
          http.MultipartRequest('POST', Uri.parse(api.baseUrl + '/order/'));
      request.headers.addAll(requestHeaders);
      request.files
          .add(await http.MultipartFile.fromPath('imageFile', file.path));
      request.fields['checkin'] = f.format(checkin);
      request.fields['checkout'] = f.format(checkout);
      request.fields['total'] = '$total';
      request.fields['status'] = '2';
      request.fields['house_id'] = '$houseId';
      request.fields['booking_id'] = '$bookingId';

      var response = await request.send();
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);

      var d = jsonDecode(responseString);

      return d;
    } catch (e) {
      print(e);
    }
  }
}
