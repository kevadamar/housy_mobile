import 'dart:convert';

import 'package:dev_mobile/utils/api.dart';
import 'package:http/http.dart' as http;

class AuthServices {
  Future<dynamic> signin(String email, String password) async {
    try {
      final responseData = await http.post(Uri.parse(Api().baseUrl + '/signin'),
          body: {"email": email, "password": password});

      final data = jsonDecode(responseData.body);

      return data;
    } catch (e) {
      print('$e err');
      throw 'error from server';
    }
  }
}
