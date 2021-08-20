import 'dart:async';
import 'dart:io';

import 'package:dev_mobile/components/shimmer_effect/shimmer_effect_component.dart';
import 'package:dev_mobile/models/booking_model.dart';
import 'package:dev_mobile/providers/auth_provider.dart';
import 'package:dev_mobile/providers/booking_provider.dart';
import 'package:dev_mobile/services/services.dart';
import 'package:dev_mobile/utils/api.dart';
import 'package:dev_mobile/utils/constants.dart';
import 'package:dev_mobile/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({Key key}) : super(key: key);

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final bookingProvider =
        Provider.of<BookingProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    bookingProvider.setIsProcessing(true);

    final response = await Services.instance.getBookings(authProvider.token);

    final msg = response['message'];
    final status = response['status'];
    final data = response['data'];

    // print(data);
    if (data.length > 0) {
      final List<BookingModel> dataApi = [];
      data.forEach((api) {
        dataApi.add(BookingModel.fromJson(api));
      });

      bookingProvider.setData(dataApi);
    }
    // Timer(Duration(seconds: 3), () => bookingProvider.setIsProcessing(false));
    bookingProvider.setIsProcessing(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
              RouterGenerator.homeScreen, (route) => false),
          icon: Icon(
              Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios),
        ),
        brightness: Brightness.light,
        elevation: 0,
        backgroundColor: identityColor,
        title: Text('Booking'),
      ),
      body: RefreshIndicator(
          child: Consumer<BookingProvider>(
            builder: (context, value, child) {
              if (value.isProcessing) {
                return _bodyLoading();
              }

              // return _bodyLoading();
              return _body(context, value.data);
            },
          ),
          onRefresh: _fetchData),
    );
  }

  _bodyLoading() => ListView.builder(
        itemCount: 6,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.only(
              top: 15, left: 10, right: 10, bottom: index == 19 ? 15 : 0),
          child: Container(
            padding: EdgeInsets.all(12),
            width: 1.sw,
            height: 0.2.sh,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 4,
                    color: Colors.black.withOpacity(0.5),
                    offset: Offset(0, 2),
                  ),
                ]),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  child: ShimmerEffect(
                      widget: Container(
                    width: 0.3.sw,
                    height: 75,
                    color: Colors.grey[400],
                  )),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ShimmerEffect(
                      widget: Container(
                        width: 0.51.sw,
                        height: 20,
                        color: Colors.grey[400],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ShimmerEffect(
                      widget: Container(
                        width: 0.43.sw,
                        height: 20,
                        color: Colors.grey[400],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ShimmerEffect(
                      widget: Container(
                        width: 0.4.sw,
                        height: 20,
                        color: Colors.grey[400],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 0.45.sw,
                      height: 20,
                      color: Colors.grey[400],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

  _body(BuildContext context, List<BookingModel> booking) => ListView.builder(
        itemCount: booking.length,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.only(
              top: 15, left: 10, right: 10, bottom: index == 19 ? 15 : 0),
          child: GestureDetector(
            onTap: () => Navigator.pushReplacementNamed(
              context,
              RouterGenerator.detailBookingScreen,
              arguments: booking[index],
            ),
            child: Container(
              padding: EdgeInsets.all(12),
              // width: 0.5.sw,
              height: 0.2.sh,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4,
                      color: Colors.black.withOpacity(0.5),
                      offset: Offset(0, 2),
                    ),
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    child: Image.network(
                      Api().baseUrlImg + booking[index].house.image,
                      width: 0.3.sw,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          booking[index].house.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17.sp,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          '${formatDate(booking[0].checkin)} - ${formatDate(booking[0].checkout)}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 15.sp,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          formatRupiah(booking[0].total.toString()),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp,
                            color: Colors.red[600],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          color: Colors.red[50],
                          child: Text(
                            booking[0].status,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
}
