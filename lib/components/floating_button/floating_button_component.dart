import 'package:dev_mobile/models/booking_model.dart';
import 'package:dev_mobile/providers/auth_provider.dart';
import 'package:dev_mobile/providers/book_now_provider.dart';
import 'package:dev_mobile/services/services.dart';
import 'package:dev_mobile/utils/constants.dart';
import 'package:dev_mobile/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class FloatingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bookNowProvider = Provider.of<BookNowProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            width: deviceWidth(),
            height: 100.h,
            decoration: BoxDecoration(
              color: identityColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Total Harga",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Consumer<BookNowProvider>(
                            builder: (context, value, child) => Text(
                              formatRupiah(value.totalPrice.toString()),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 22.sp,
                              ),
                            ),
                          ),
                        ]),
                  ),
                  MaterialButton(
                    onPressed: () async {
                      String houseId = bookNowProvider.houseId.toString();
                      DateTime checkin = bookNowProvider.checkin;
                      DateTime checkout = bookNowProvider.checkout;
                      int total = bookNowProvider.totalPrice;
                      String token = authProvider.token;

                      final response = await Services.instance.postBooking(
                          houseId, checkin, checkout, total, token);

                      BookingModel booking =
                          BookingModel.fromJson(response['data']);

                      Navigator.pushReplacementNamed(
                        context,
                        RouterGenerator.detailBookingScreen,
                        arguments: booking,
                      );
                    },
                    child: Text("ORDER NOW"),
                    textColor: identityColor,
                    color: Colors.white,
                  )
                ],
              ),
            )),
      ],
    );
  }
}
