import 'dart:convert';

import 'package:dev_mobile/utils/api.dart';
import 'package:http/http.dart' as http;

class HouseServices {
  Api api = Api();

  Future<dynamic> getHouses() async {
    try {
      final responseData = await http.get(
        Uri.parse(api.baseUrl + '/houses'),
      );

      final data = jsonDecode(responseData.body);

      return data;
    } catch (e) {
      print('$e err');
      throw 'error from server';
    }
  }
}
