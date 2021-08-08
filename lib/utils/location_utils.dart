import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:location/location.dart';

class LocationUtils {
  double latitude;
  double longitude;
  String city;
  static LocationUtils instance = LocationUtils();

  void getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    var _serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!_serviceEnabled) {
      return;
    }

    var _permissionGranted = await Geolocator.checkPermission();
    if (_permissionGranted == LocationPermission.denied) {
      _permissionGranted = await Geolocator.requestPermission();
      if (_permissionGranted == LocationPermission.denied) {
        return;
      }
    }

    var _locationData = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print('loc $_locationData');
    latitude = _locationData.latitude;
    longitude = _locationData.longitude;
  }

  Future<String> getAddress() async {
    var addresses = await Geocoder.local
        .findAddressesFromCoordinates(Coordinates(latitude, longitude));
    print(addresses.first.adminArea);
    city = addresses.first.adminArea;
    return addresses.first.addressLine;
  }
}
