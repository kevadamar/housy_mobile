import 'dart:async';

import 'package:dev_mobile/components/search_item/search_item_component.dart';
import 'package:dev_mobile/components/shimmer_effect/shimmer_effect_component.dart';

import 'package:dev_mobile/models/house_model.dart';
import 'package:dev_mobile/providers/location_providers.dart';
import 'package:dev_mobile/services/services.dart';
import 'package:dev_mobile/utils/api.dart';
import 'package:dev_mobile/utils/constants.dart';

import 'package:dev_mobile/utils/routes.dart';
import 'package:dev_mobile/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var searchController = TextEditingController();
  List<Widget> listData = [];
  List<Widget> listDataDisekitar = [];
  List<HouseModel> listDisekitar = [];
  bool isLoading = false;
  DateTime timedBackPressed = DateTime.now();

  final GlobalKey<RefreshIndicatorState> _refresh =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() {
      isLoading = true;
      listDataDisekitar = [];
      listDisekitar = [];
    });
    final response = await Services.instance.getHouses();

    final msg = response['message'];
    final status = response['status'];
    final data = response['data'];
    data.forEach((api) {
      // listData.add(_cardItem(HouseModel.fromJson(api)));
      // listDataDisekitar.add(_cardItemDisekitar(HouseModel.fromJson(api)));
      listDisekitar.add(HouseModel.fromJson(api));
    });

    Timer(Duration(seconds: 2), () => setState(() => isLoading = false));
  }

  getCoder() async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    print(position);

    final coordinates =
        await Coordinates(position.latitude, position.longitude);

    var address =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);

    print(address.first.addressLine);
  }

  @override
  Widget build(BuildContext context) {
    setStatusBar(brightness: Brightness.light);

    return WillPopScope(
      onWillPop: () async {
        print('ww ');
        final difference = DateTime.now().difference(timedBackPressed);
        final isExitWarn = difference >= Duration(seconds: 2);

        timedBackPressed = DateTime.now();
        if (isExitWarn) {
          Fluttertoast.showToast(msg: "Press back again to exit", fontSize: 18);
          return false;
        } else {
          Fluttertoast.cancel();
          return true;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: identityColor,
          elevation: 0,
          title: SearchItem(
            controller: searchController,
            readOnly: true,
          ),
        ),
        body: RefreshIndicator(
          onRefresh: _fetchData,
          key: _refresh,
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    color: identityColor,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _locationWidget(),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        SizedBox(
                          height: 12,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            'Rumah disekitar anda',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ConstrainedBox(
                          constraints: BoxConstraints(
                              maxHeight: 0.30.sh, minHeight: 0.25.sh),
                          child: ListView(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            children: isLoading
                                ? [
                                    ...List.generate(
                                      5,
                                      (index) => _shimmerEffectCard(),
                                    ),
                                  ]
                                : List.generate(
                                    listDisekitar.length,
                                    (index) => _cardItemDisekitar(
                                        context, listDisekitar[index]),
                                  ),
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            'Rumah',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Column(mainAxisSize: MainAxisSize.max, children: [
                          GridView.count(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            crossAxisCount: 2,
                            childAspectRatio: 0.82.h,
                            children: isLoading
                                ? [
                                    ...List.generate(
                                      4,
                                      (index) => _shimmerEffectCard(),
                                    ),
                                  ]
                                : List.generate(
                                    listDisekitar.length,
                                    (index) => _cardItem(
                                        context, listDisekitar[index]),
                                  ),
                          ),
                        ]),
                        SizedBox(
                          height: 100.h,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              navigation(),
            ],
            alignment: AlignmentDirectional.bottomCenter,
          ),
        ),
      ),
    );
  }

  Widget navigation() {
    return Positioned(
        bottom: 30,
        child: Container(
          color: Colors.transparent,
          width: deviceWidth(),
          height: setHeight(100),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 4.0,
                    offset: Offset(0, 1),
                  ),
                ]),
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).pushNamed(
                    RouterGenerator.signinScreen,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: identityColor,
                            borderRadius: BorderRadius.circular(50)),
                        child: Icon(
                          Icons.calendar_today,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text('Booking'),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => null,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: identityColor,
                            borderRadius: BorderRadius.circular(50)),
                        child: Icon(
                          Icons.history_edu,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text('Riwayat'),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => null,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: identityColor,
                            borderRadius: BorderRadius.circular(50)),
                        child: Icon(
                          Icons.account_circle_outlined,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text('Akun'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

_shimmerEffectLocaton() => ShimmerEffect(
      widget: Container(
        child: Text(
          'Location . . . . .',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

_shimmerEffectCard() => Container(
      padding: EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 3.0,
              blurRadius: 5.0,
            )
          ],
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(topRight: Radius.circular(15)),
              child: ShimmerEffect(
                widget: Container(
                  width: 210,
                  height: 90,
                  color: Colors.grey[400],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(left: 5, right: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerEffect(
                    widget: Container(
                      height: 20,
                      width: 130,
                      color: Colors.grey[400],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  ShimmerEffect(
                    widget: Container(
                      height: 20,
                      width: 100,
                      color: Colors.grey[400],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  ShimmerEffect(
                    widget: Container(
                      height: 22,
                      width: 200,
                      color: Colors.grey[400],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      ShimmerEffect(
                        widget: Container(
                          height: 20,
                          width: 20,
                          color: Colors.grey[400],
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      ShimmerEffect(
                        widget: Container(
                          height: 20,
                          width: setWidth(150),
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );

Widget _cardItemDisekitar(BuildContext context, HouseModel data) {
  return Padding(
    padding: EdgeInsets.all(10),
    child: GestureDetector(
      onTap: () => Navigator.pushNamed(
          context, RouterGenerator.detailProductScreen,
          arguments: data),
      child: Container(
        width: 200.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 3.0,
                blurRadius: 5.0,
              )
            ],
            color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(topRight: Radius.circular(15)),
              child: Image.network(
                Api().baseUrlImg + data.image,
                fit: BoxFit.cover,
                width: 1.sw,
                height: 0.1.sh,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(left: 5, right: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    formatRupiah(data.price.toString()),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.red[600],
                      fontWeight: FontWeight.bold,
                      fontSize: 17.5.sp,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    '${data.bedroom} Beds, ${data.bathroom} Baths, ${data.area} Sqft',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15.sp,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_pin,
                        color: identityColor,
                        size: 15.sp,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Text(
                          data.city,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}

Widget _cardItem(BuildContext context, HouseModel data) {
  return Padding(
    padding: EdgeInsets.all(10),
    child: GestureDetector(
      onTap: () => Navigator.pushNamed(
          context, RouterGenerator.detailProductScreen,
          arguments: data),
      child: Container(
        width: 200.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 3.0,
                blurRadius: 5.0,
              )
            ],
            color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(topRight: Radius.circular(15)),
              child: Image.network(
                Api().baseUrlImg + data.image,
                fit: BoxFit.cover,
                width: 1.sw,
                height: 0.1.sh,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(left: 5, right: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    formatRupiah(data.price.toString()),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.red[600],
                      fontWeight: FontWeight.bold,
                      fontSize: 17.5.sp,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    '${data.bedroom} Beds, ${data.bathroom} Baths, ${data.area} Sqft',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15.sp,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_pin,
                        color: identityColor,
                        size: 15.sp,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Text(
                          data.city,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}

Widget _locationWidget() {
  return Container(
    color: identityColor,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.location_on, color: Colors.white, size: 25),
            SizedBox(width: 5),
            Consumer<LocationProvider>(
              builder: (context, locationProv, _) {
                //* If location address stil null

                if (locationProv.address == null) {
                  locationProv.loadLocation();
                  return _shimmerEffectLocaton();
                }

                return Expanded(
                  child: Text(
                    locationProv.address,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white),
                  ),
                );
              },
            )
          ],
        ),
        Divider(color: Colors.white38),
      ],
    ),
  );
}
