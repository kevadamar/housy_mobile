import 'package:dev_mobile/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class BookNowContent extends StatefulWidget {
  final int price;

  const BookNowContent({Key key, @required this.price}) : super(key: key);

  @override
  _BookNowContentState createState() => _BookNowContentState();
}

class _BookNowContentState extends State<BookNowContent> {
  DateTime initCheckinDate;
  DateTime initCheckoutDate;
  DateTime checkin;
  DateTime checkout;
  int totalPrice;

  @override
  void initState() {
    super.initState();
    var datenow = DateTime.now().add(Duration(days: 1));

    setState(() {
      initCheckinDate = DateTime(datenow.year, datenow.month, datenow.day);
      initCheckoutDate = initCheckinDate.add(Duration(days: 1));
      checkin = initCheckinDate;
      checkout = initCheckoutDate;
      totalPrice = widget.price;
      // Duration duration = checkout.difference(checkin);
      // print(checkin);
      // print(duration.inDays);
      // print(checkout);
    });
  }

  void setCheckinState(DateTime date) {
    setState(() {
      // print(date);
      checkin = date;
      initCheckoutDate = checkin.add(Duration(days: 1));
      if (checkin.day >= checkout.day) {
        checkout = initCheckoutDate;
      }
      Duration duration = checkout.difference(checkin);
      totalPrice = widget.price * (duration.inDays);
    });
  }

  void setCheckoutState(DateTime date) {
    setState(() {
      checkout = date;
      Duration duration = checkout.difference(checkin);
      // print(duration.inDays);
      // print('${checkin.hour} cek in');
      // print(checkout.hour);
      totalPrice = widget.price * (duration.inDays);
    });
  }

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
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
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
            ...selectDatePicker(context, "Check In", checkin, initCheckinDate),
            SizedBox(
              height: 25.h,
            ),
            ...selectDatePicker(
                context, "Check Out", checkout, initCheckoutDate),
            SizedBox(
              height: 40.h,
            ),
            Container(
              width: 0.85.sw,
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.red,
                  ),
                  borderRadius: BorderRadius.circular(18.0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Total Price',
                    style: TextStyle(
                      fontSize: 24.sp,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Text(
                    formatRupiah(totalPrice.toString()),
                    style: TextStyle(
                      fontSize: 24.sp,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> selectDatePicker(BuildContext context, String title,
          DateTime state, DateTime initFirstDate) =>
      [
        Container(
          width: 0.8.sw,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
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
        OutlinedButton(
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
            if (value != null && title.toLowerCase() == 'check in') {
              setState(() => setCheckinState(value));
            }
            if (value != null && title.toLowerCase() == 'check out') {
              setState(() => setCheckoutState(value));
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
        ),
      ];
}
