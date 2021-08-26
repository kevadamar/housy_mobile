import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:dev_mobile/utils/api.dart';

class CityServices {
  Api api = Api();

  Future<dynamic> getCities() async {
    try {
      final responseData = await http.get(
        Uri.parse(api.baseUrl + '/cities'),
      );

      final data = jsonDecode(responseData.body);
      return data;
    } catch (e) {
      print('$e err');
      throw 'error from server';
    }
  }
}
