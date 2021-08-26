import 'dart:convert';

import 'package:dev_mobile/providers/auth_provider.dart';
import 'package:dev_mobile/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AuthServices {
  Api api = Api();

  Future<dynamic> signin(String email, String password) async {
    try {
      final responseData = await http.post(Uri.parse(api.baseUrl + '/signin'),
          body: {"email": email, "password": password});

      final data = jsonDecode(responseData.body);

      return data;
    } catch (e) {
      print('$e err');
      throw 'error from server';
    }
  }

  Future<dynamic> signup(
    String fullname,
    String username,
    String email,
    String password,
    String roleId,
    String gender,
    String phoneNumber,
    String address,
  ) async {
    try {
      final responseData =
          await http.post(Uri.parse(api.baseUrl + '/signup'), body: {
        "email": email,
        "password": password,
        "fullname": fullname,
        "username": username,
        "gender": gender.toLowerCase(),
        "address": address,
        "role_id": roleId,
        "phone_number": phoneNumber.substring(1)
      });

      final data = jsonDecode(responseData.body);
      print(data['status']);
      return data;
    } catch (e) {
      print('$e err');
      throw 'error from server';
    }
  }

  Future<dynamic> updateProfile(
    BuildContext context,
    String fullname,
    String username,
    String phoneNumber,
    String address,
  ) async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      final requestHeaders = {'Authorization': 'Bearer ${authProvider.token}'};

      var request = http.MultipartRequest(
          'PATCH', Uri.parse(api.baseUrl + '/user/update-photo'));
      request.headers.addAll(requestHeaders);
      if (authProvider.imageFile != null) {
        request.files.add(await http.MultipartFile.fromPath(
            'imageFile', authProvider.imageFile.path));
      }
      request.fields['fullname'] = fullname;
      request.fields['username'] = username;
      request.fields['address'] = address;
      request.fields['phone_number'] = phoneNumber.substring(1);

      var response = await request.send();
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);

      var d = jsonDecode(responseString);

      return d;
    } catch (e) {
      print('$e err');
      throw 'error from server';
    }
  }

  Future<dynamic> getUserByToken(String token) async {
    try {
      final requestHeaders = {'Authorization': 'Bearer $token'};
      final responseData = await http.get(
          Uri.parse(
            api.baseUrl + '/auth/me',
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
