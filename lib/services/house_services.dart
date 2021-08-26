import 'dart:convert';

import 'package:dev_mobile/providers/auth_provider.dart';
import 'package:dev_mobile/providers/houses_provider.dart';
import 'package:dev_mobile/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class HouseServices {
  Api api = Api();

  Future<dynamic> addHouse(BuildContext context, String name, int price,
      String address, int area, String description) async {
    try {
      final housesProvider =
          Provider.of<HousesProvider>(context, listen: false);
      final token = Provider.of<AuthProvider>(context, listen: false).token;

      final requestHeaders = {'Authorization': 'Bearer $token'};

      var request =
          http.MultipartRequest('POST', Uri.parse(api.baseUrl + '/house'));
      request.headers.addAll(requestHeaders);
      request.files.add(await http.MultipartFile.fromPath(
          'imageFile', housesProvider.imageFileOne.path));
      if (housesProvider.imageFileTwo != null) {
        request.files.add(await http.MultipartFile.fromPath(
            'imageFile', housesProvider.imageFileTwo.path));
      }
      if (housesProvider.imageFileThree != null) {
        request.files.add(await http.MultipartFile.fromPath(
            'imageFile', housesProvider.imageFileThree.path));
      }
      if (housesProvider.imageFileFourth != null) {
        request.files.add(await http.MultipartFile.fromPath(
            'imageFile', housesProvider.imageFileFourth.path));
      }

      request.fields['name'] = name;
      request.fields['price'] = '$price';
      request.fields['city_id'] = '${housesProvider.city.id}';
      request.fields['address'] = address;
      request.fields['bedroom'] = '${housesProvider.bedroom}';
      request.fields['bathroom'] = '${housesProvider.bathroom}';
      request.fields['area'] = '$area';
      request.fields['description'] = description;

      var response = await request.send();
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);

      var d = jsonDecode(responseString);

      return d;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> updateHouse(BuildContext context, String name, int price,
      String address, int area, String description, int houseId) async {
    try {
      final housesProvider =
          Provider.of<HousesProvider>(context, listen: false);
      final token = Provider.of<AuthProvider>(context, listen: false).token;

      final requestHeaders = {'Authorization': 'Bearer $token'};

      var request = http.MultipartRequest(
          'PATCH', Uri.parse(api.baseUrl + '/house/' + houseId.toString()));
      request.headers.addAll(requestHeaders);
      request.files.add(await http.MultipartFile.fromPath(
          'imageFile', housesProvider.imageFileOne.path));
      if (housesProvider.imageFileTwo != null) {
        request.files.add(await http.MultipartFile.fromPath(
            'imageFile', housesProvider.imageFileTwo.path));
      }
      if (housesProvider.imageFileThree != null) {
        request.files.add(await http.MultipartFile.fromPath(
            'imageFile', housesProvider.imageFileThree.path));
      }
      if (housesProvider.imageFileFourth != null) {
        request.files.add(await http.MultipartFile.fromPath(
            'imageFile', housesProvider.imageFileFourth.path));
      }

      request.fields['name'] = name;
      request.fields['price'] = '$price';
      request.fields['city_id'] = '${housesProvider.city.id}';
      request.fields['address'] = address;
      request.fields['bedroom'] = '${housesProvider.bedroom}';
      request.fields['bathroom'] = '${housesProvider.bathroom}';
      request.fields['area'] = '$area';
      request.fields['description'] = description;

      var response = await request.send();
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);

      var d = jsonDecode(responseString);

      return d;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> deleteHouse(BuildContext context, int houseId) async {
    try {
      final token = Provider.of<AuthProvider>(context, listen: false).token;

      final requestHeaders = {'Authorization': 'Bearer $token'};

      final responseData = await http.delete(
        Uri.parse(api.baseUrl + '/house/' + houseId.toString()),
        headers: requestHeaders,
      );

      final data = jsonDecode(responseData.body);

      return data;
    } catch (e) {
      print('$e err');
      throw 'error from server';
    }
  }

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

  Future<dynamic> getHousesByToken(String token) async {
    try {
      final requestHeaders = {'Authorization': 'Bearer $token'};

      final responseData = await http.get(
        Uri.parse(api.baseUrl + '/owner/houses'),
        headers: requestHeaders,
      );

      final data = jsonDecode(responseData.body);

      return data;
    } catch (e) {
      print('$e err');
      throw 'error from server';
    }
  }

  Future<dynamic> getHousesDisekitar(String city) async {
    try {
      city = city.toLowerCase();
      final responseData = await http.get(
        Uri.parse(api.baseUrl + '/houses/location?city=$city'),
      );

      final data = jsonDecode(responseData.body);

      return data;
    } catch (e) {
      print('$e err');
      throw 'error from server';
    }
  }

  Future<dynamic> getHousesByFilterCombination(
      String city, String price) async {
    try {
      city = city.toLowerCase();
      final responseData = await http.get(
        Uri.parse(api.baseUrl + '/houses?city=$city&price=$price'),
      );

      final data = jsonDecode(responseData.body);

      return data;
    } catch (e) {
      print('$e err');
      throw 'error from server';
    }
  }
}
