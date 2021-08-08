import 'package:dev_mobile/models/directions_model.dart';
import 'package:dev_mobile/utils/constants.dart';
import 'package:dev_mobile/utils/directions_repository.dart';
import 'package:dev_mobile/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapComponent extends StatefulWidget {
  const MapComponent({Key key}) : super(key: key);

  @override
  _MapComponentState createState() => _MapComponentState();
}

class _MapComponentState extends State<MapComponent> {
  static final CameraPosition _kInitialPosition =
      CameraPosition(target: LatLng(-6.1938042, 106.59343), zoom: 15.0);

  GoogleMapController _googleMapController;
  Marker _origin;
  Marker _destination;

  DirectionsModel _info;

  PolylinePoints polylinePoints = PolylinePoints();

  Marker _myLocation = Marker(
    markerId: const MarkerId('origin'),
    infoWindow: InfoWindow(title: 'You'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    position: LatLng(-6.1938042, 106.59343),
  );

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setStatusBar(brightness: Brightness.light);

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: identityColor,
        title: Text('MapComponentn'),
      ),
      body: Stack(alignment: Alignment.center, children: [
        GoogleMap(
          initialCameraPosition: _kInitialPosition,
          onMapCreated: (controller) => _googleMapController = controller,
          markers: {
            _myLocation,
            if (_destination != null) _destination,
          },
          myLocationEnabled: true,
          onTap: (pos) {
            print(pos);
            _addMarker(pos);
          },
        ),
      ]),
      // Center(
      //   child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      //     Container(
      //       child: MaterialButton(
      //         onPressed: () => Navigator.of(context).pushNamed(RouterGenerator.signinScreen),
      //         child: Text('Sign In'),
      //       ),
      //     ),
      //     SizedBox(
      //       height: 20,
      //     ),
      //     Container(
      //       child: GoogleMap(initialCameraPosition: _kInitialPosition),
      //     ),
      //     SizedBox(
      //       height: 20,
      //     ),
      //     // Container(
      //     //   child: SingleChildScrollView(
      //     //     child: StaggeredGridView.countBuilder(
      //     //       crossAxisCount: 4,
      //     //       mainAxisSpacing: 2,
      //     //       crossAxisSpacing: 2,
      //     //       itemCount: 30,
      //     //       itemBuilder: (context, index) => _cardItem(index),
      //     //       // staggeredTileBuilder: (index) =>
      //     //       //     StaggeredTile.count(2, index.isEven ? 3 : 2),
      //     //       staggeredTileBuilder: (index) => StaggeredTile.fit(2),
      //     //     ),
      //     //   ),
      //     // ),
      //   ]),
      // ),
    );
  }

  void _addMarker(LatLng pos) async {
    // set State for set destination
    setState(() {
      // set destination
      _destination = Marker(
        markerId: const MarkerId('destination'),
        infoWindow: InfoWindow(title: 'Destination'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        position: pos,
      );
    });

    // get directions

    // final directions = await DirectionsRepository().getDirections(
    //   origin: _myLocation.position,
    //   destination: pos,
    // );

    // setState(() => _info = directions);
  }
}

_cardItem(int index) {
  return Card(
    // color: Colors.grey,
    child: Center(
      child: Container(
        padding: EdgeInsets.all(15),
        // height: 150.w,
        child: Column(
          children: [
            Image.asset(
              "assets/images/splash2.jpg",
              fit: BoxFit.contain,
              width: 120,
              height: 120,
            ),
            Text('ini card $index')
          ],
        ),
      ),
    ),
  );
}
