import 'package:dev_mobile/models/house_model.dart';
import 'package:dev_mobile/services/services.dart';
import 'package:dev_mobile/utils/routes.dart';
import 'package:flutter/material.dart';

class HousesProvider extends ChangeNotifier {
  /// state
  List<HouseModel> _data = [];
  List<HouseModel> _dataSekitar = [];
  bool _isProcessing = false;
  bool _isProcessingSekitar = false;
  bool _onSearch = false;
  List<HouseModel> _searchByFilter;
  bool _fromHome = true;

  // getter state
  List<HouseModel> get data => _data;
  List<HouseModel> get dataSekitar => _dataSekitar;
  List<HouseModel> get searchByFilter => _searchByFilter;
  bool get isProcessing => _isProcessing;
  bool get isProcessingSekitar => _isProcessingSekitar;
  bool get onSearch => _onSearch;
  bool get fromHome => _fromHome;

  // set state
  void setData(List<HouseModel> res) {
    _data = res;
    notifyListeners();
  }

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
    notifyListeners();
  }

  void setIsProcessingSekitarTrue() {
    _isProcessingSekitar = true;
    notifyListeners();
  }

  void setOnSearch(bool status) {
    _onSearch = status;
    notifyListeners();
  }

  void clearHouseSearch() {
    _searchByFilter = null;
    notifyListeners();
  }

  void searchHouseByFilterCity(String city, BuildContext context) async {
    setOnSearch(true);
    clearHouseSearch();
    final response = await Services.instance.getHousesDisekitar(city);
    final data = response['data'];
    if (data.length > 0) {
      final List<HouseModel> dataApi = [];
      data.forEach((api) {
        dataApi.add(HouseModel.fromJson(api));
      });

      _searchByFilter = dataApi;
    } else {
      _searchByFilter = [];
    }
    setOnSearch(false);
  }

  void routeToSearchHouse(BuildContext context) {
    clearHouseSearch();
    Navigator.of(context).pushNamed(RouterGenerator.searchScreen);
  }
}
