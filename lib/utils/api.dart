import 'dart:convert';

import 'package:http/http.dart' as http;

class Api {
  final String baseUrl = "http://192.168.1.3:5000/api/v1";
  final String baseUrlImg = "http://192.168.1.3:5000/uploads/";

  Future<dynamic> getDataApi(String pathUrl) async {
    final responseData = await http.get(Uri.parse('$baseUrl$pathUrl'));

    final data = jsonDecode(responseData.body);

    return data;
  }

  Future<dynamic> postDataApi(String pathUrl, Map<String, dynamic> payload,
      Map<String, String> headres) async {
    final responseData = await http.post(Uri.parse('$baseUrl$pathUrl'),
        body: payload, headers: headres);

    final data = jsonDecode(responseData.body);

    return data;
  }
}
