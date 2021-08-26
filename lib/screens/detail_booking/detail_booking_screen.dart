import 'package:dev_mobile/components/custom_appbar/custom_appbar_component.dart';
import 'package:dev_mobile/models/booking_model.dart';
import 'package:dev_mobile/screens/detail_booking/widget/detail_content.dart';

import 'package:dev_mobile/utils/routes.dart';
import 'package:flutter/material.dart';

class DetailBookingScreen extends StatefulWidget {
  final BookingModel booking;
  const DetailBookingScreen({Key key, @required this.booking})
      : super(key: key);

  @override
  _DetailBookingScreenState createState() => _DetailBookingScreenState();
}

class _DetailBookingScreenState extends State<DetailBookingScreen> {
  @override
  Widget build(BuildContext context) {
    final booking = widget.booking;

    return Scaffold(
      appBar: CustomAppBar(
        routeBack: false,
        routeBackCb: RouterGenerator.bookingScreen,
      ),
      body: DetailContent(
        booking: booking,
      ),
    );
  }
}
