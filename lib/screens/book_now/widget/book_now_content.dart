import 'package:dev_mobile/providers/book_now_provider.dart';
import 'package:dev_mobile/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BookNowContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('print me');
    return Flexible(
      flex: 1,
      child: Container(
        margin: EdgeInsets.only(top: 20),
        padding: EdgeInsets.only(
          top: 45.h,
          left: 12,
          right: 12,
        ),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            // topLeft: Radius.circular(20),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
                spreadRadius: 0.1,
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10.0)
          ],
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 0.8.sw,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Check In",
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: identityColor,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Consumer<BookNowProvider>(
              builder: (context, value, child) => datePicker(context, value,
                  "checkin", value.checkin, value.initCheckinDate),
            ),
            SizedBox(
              height: 25.h,
            ),
            Container(
              width: 0.8.sw,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Check Out",
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: identityColor,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Consumer<BookNowProvider>(
              builder: (context, value, child) => datePicker(context, value,
                  "checkout", value.checkout, value.initCheckoutDate),
            ),
            SizedBox(
              height: 40.h,
            ),
          ],
        ),
      ),
    );
  }

  datePicker(BuildContext context, BookNowProvider provider, String title,
      DateTime state, DateTime initFirstDate) {
    return OutlinedButton(
      style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
          ),
          side: MaterialStateProperty.all(
            BorderSide(color: identityColor, width: 1),
          )),
      onPressed: () => showDatePicker(
        context: context,
        initialDate: state,
        firstDate: initFirstDate,
        lastDate: DateTime(DateTime.now().year + 11),
        helpText: "Select Booking Date",
      ).then((value) {
        if (value != null && title.toLowerCase() == 'checkin') {
          provider.setCheckin(value);
        }
        if (value != null && title.toLowerCase() == 'checkout') {
          provider.setCheckout(value);
        }
      }),
      child: Container(
        width: 0.8.sw,
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: Text(
          DateFormat('dd/MM/y').format(state).toString(),
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: identityColor,
          ),
        ),
      ),
    );
  }
}
