import 'package:dev_mobile/models/booking_model.dart';
import 'package:dev_mobile/models/house_model.dart';
import 'package:dev_mobile/providers/booking_provider.dart';
import 'package:dev_mobile/screens/detail_booking/widget/detail_information.dart';
import 'package:dev_mobile/screens/detail_booking/widget/small_preview.dart';

import 'package:dev_mobile/utils/api.dart';
import 'package:dev_mobile/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class DetailContent extends StatelessWidget {
  final BookingModel booking;
  const DetailContent({Key key, this.booking}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HouseModel house = booking.house;

    return SafeArea(
      child: Column(
        children: [
          Consumer<BookingProvider>(
            builder: (context, value, child) {
              return imagePreview(
                  house,
                  value.selectedImg == null || value.selectedImg.length == 0
                      ? house.image
                      : value.selectedImg,
                  (img) => value.setSelecetImg(img));
            },
          ),
          DetailInformation(
            booking: booking,
          ),
        ],
      ),
    );
  }

  Widget imagePreview(HouseModel house, String selectedImg, Function setState) {
    return Container(
      width: deviceWidth(),
      height: deviceHeight() * 0.3,
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
      child: Image.network(
        Api().baseUrlImg + selectedImg,
        fit: BoxFit.fill,
      ),
    );
  }
}
