import 'package:flutter/foundation.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DirectionsModel {
  final LatLngBounds bounds;
  final List<PointLatLng> polylinePoints;
  final String totalDistances;
  final String totalDuration;

  const DirectionsModel({
    @required this.bounds,
    @required this.polylinePoints,
    @required this.totalDistances,
    @required this.totalDuration,
  });

  factory DirectionsModel.fromMap(Map<String, dynamic> map) {
    // check if null
    if ((map['routes'] as List).isEmpty) return null;

    final data = Map<String, dynamic>.from(map['routes'][0]);
    //bounds
    final northeast = data['bounds']['northeast'];
    final southwest = data['bounds']['southwest'];

    final bounds = LatLngBounds(
      southwest: LatLng(southwest['lat'], southwest['lng']),
      northeast: LatLng(
        northeast['lat'],
        northeast['lng'],
      ),
    );

    //distance & duration

    String distance = '';
    String duration = '';

    if ((data['legs'] as List).isEmpty) {
      final leg = data['legs'][0];
      distance = leg['distance']['text'];
      duration = leg['duration']['text'];
    }

    return DirectionsModel(
      bounds: bounds,
      polylinePoints: PolylinePoints().decodePolyline(data['overview_polyline']['points']),
      totalDistances: distance,
      totalDuration: duration,
    );
  }
}
