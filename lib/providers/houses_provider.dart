import 'dart:io';

import 'package:dev_mobile/models/city_model.dart';
import 'package:dev_mobile/models/house_model.dart';
import 'package:dev_mobile/services/services.dart';
import 'package:dev_mobile/utils/routes.dart';
import 'package:flutter/material.dart';

class HousesProvider extends ChangeNotifier {
  /// state
  List<HouseModel> _data = [];
  List<HouseModel> _dataSekitar = [];
  bool _isProcessing = true;
  bool _isProcessingSekitar = true;
  bool _onSearch = false;
  List<HouseModel> _searchByFilter;
  bool _fromHome = true;
  bool _showFilter = true;
  String _bedroom = '1';
  String _bathroom = '1';
  CityModel _city;
  HouseModel _house;
  File _imageFileOne;
  File _imageFileTwo;
  File _imageFileThree;
  File _imageFileFourth;

  // getter state
  List<HouseModel> get data => _data;
  List<HouseModel> get dataSekitar => _dataSekitar;
  List<HouseModel> get searchByFilter => _searchByFilter;
  bool get isProcessing => _isProcessing;
  bool get isProcessingSekitar => _isProcessingSekitar;
  bool get onSearch => _onSearch;
  bool get fromHome => _fromHome;
  bool get showFilter => _showFilter;
  HouseModel get house => _house;
  CityModel get city => _city;
  String get bedroom => _bedroom;
  String get bathroom => _bathroom;
  File get imageFileOne => _imageFileOne;
  File get imageFileTwo => _imageFileTwo;
  File get imageFileThree => _imageFileThree;
  File get imageFileFourth => _imageFileFourth;

  // set state
  void setData(List<HouseModel> res) {
    _data = res;
    notifyListeners();
  }

  void resetImage() {
    _imageFileOne = null;
    _imageFileTwo = null;
    _imageFileThree = null;
    _imageFileFourth = null;
  }

  void setImageFileOne(File image) {
    _imageFileOne = image;
    notifyListeners();
  }

  void setImageFileTwo(File image) {
    _imageFileTwo = image;
    notifyListeners();
  }

  void setImageFileThree(File image) {
    _imageFileThree = image;
    notifyListeners();
  }

  void setImageFileFourth(File image) {
    _imageFileFourth = image;
    notifyListeners();
  }

  void setBedroom(String value) {
    _bedroom = value;
    notifyListeners();
  }

  void setInitBedroom(String value) => _bedroom = value;
  void setBathroom(String value) {
    _bathroom = value;
    notifyListeners();
  }

  void setInitBathroom(String value) => _bathroom = value;

  void setCity(CityModel city) => _city = city;

  void setHouse(HouseModel house) => _house = house;

  void setDataSekitar(List<HouseModel> res) {
    _dataSekitar = res;
    notifyListeners();
  }

  void setIsProcessing(bool status) {
    _isProcessing = status;
    notifyListeners();
  }

  void setFromHome(bool status) {
    _fromHome = status;
  }

  void setIsProcessingDisekitar(bool status) {
    _isProcessingSekitar = status;
    notifyListeners();
  }

  void setIsProcessingTrue() {
    _isProcessing = true;
    print('set tr');
    notifyListeners();
  }

  void setIsProcessingSekitarTrue() {
    _isProcessingSekitar = true;
    // notifyListeners();
  }

  void setOnSearch(bool status) {
    _onSearch = status;
    notifyListeners();
  }

  void clearHouseSearch() {
    _searchByFilter = null;
    notifyListeners();
  }

  void setShowFilter(bool show) {
    _showFilter = show;
    notifyListeners();
  }

  void searchHouseByFilterCity(String city, BuildContext context) async {
    setOnSearch(true);
    clearHouseSearch();
    final response = await Services.instance.getHousesDisekitar(city);
    final data = response['data'];
    if (data.length > 0) {
      setShowFilter(true);
      final List<HouseModel> dataApi = [];
      data.forEach((api) {
        dataApi.add(HouseModel.fromJson(api));
      });

      _searchByFilter = dataApi;
    } else {
      setShowFilter(false);
      _searchByFilter = [];
    }
    setOnSearch(false);
  }

  void searchHouseByFilterCombination(
      String city, BuildContext context, String price) async {
    setOnSearch(true);
    clearHouseSearch();
    final response =
        await Services.instance.getHousesByFilterCombination(city, price);
    final data = response['data'];
    if (data.length > 0) {
      setShowFilter(true);
      final List<HouseModel> dataApi = [];
      data.forEach((api) {
        dataApi.add(HouseModel.fromJson(api));
      });

      _searchByFilter = dataApi;
    } else {
      setShowFilter(false);
      _searchByFilter = [];
    }
    setOnSearch(false);
  }

  void routeToSearchHouse(BuildContext context) {
    clearHouseSearch();
    Navigator.of(context).pushNamed(RouterGenerator.searchScreen);
  }
}
