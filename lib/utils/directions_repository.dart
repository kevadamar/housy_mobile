import 'dart:convert';

import 'package:dev_mobile/models/directions_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class DirectionsRepository {
  static const String _baseUrlMaps =
      'https://maps.gooleapis.com/maps/api/directions/json?';

  // final Dio _dio = Dio();

  // DirectionsRepository({Dio dio}) : _dio = dio ??  Dio();

  Future<DirectionsModel> getDirections(
      {@required LatLng origin, @required LatLng destination}) async {
    String googleAPIKey = 'API-KEY';

    final queryParameters = {
      'origin': '${origin.latitude},${origin.longitude}',
      'destination': '${destination.latitude},${destination.longitude}',
      'key': googleAPIKey,
    };
    final uri = Uri.parse(_baseUrlMaps +
        'origin=${origin.latitude},${origin.longitude}&destination=${destination.latitude},${destination.longitude}&key=$googleAPIKey');
    final response = await http.get(
      uri,
    );

    // check if response successfully
    print(response);
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      print('aku');
      print(responseData);
      return DirectionsModel.fromMap(responseData['data']);
    }
    return null;
  }
}
