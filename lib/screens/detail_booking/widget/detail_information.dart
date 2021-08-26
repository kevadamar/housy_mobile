import 'package:dev_mobile/models/booking_model.dart';
import 'package:dev_mobile/models/house_model.dart';
import 'package:dev_mobile/models/user_model.dart';
import 'package:dev_mobile/providers/booking_provider.dart';
import 'package:dev_mobile/services/services.dart';
import 'package:dev_mobile/utils/constants.dart';
import 'package:dev_mobile/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class DetailInformation extends StatelessWidget {
  final BookingModel booking;

  const DetailInformation({Key key, @required this.booking}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HouseModel house = booking.house;
    UserModel user = booking.user;

    final bookingProvider =
        Provider.of<BookingProvider>(context, listen: false);

    return Flexible(
      child: Container(
        margin: EdgeInsets.only(top: 15.h),
        padding: EdgeInsets.only(
          top: 15.h,
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
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Information',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 0.4.sw,
                    child: Divider(
                      color: Colors.black,
                      thickness: 3,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Status'),
                      Container(
                        padding: EdgeInsets.all(5),
                        color: Colors.red[50],
                        child: Text(
                          booking.status,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: Colors.red,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Rumah'),
                      Text(house.name),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Alamat'),
                      SizedBox(
                        width: 0.5.sw,
                        child: Text(
                          house.address,
                          maxLines: 2,
                          textAlign: TextAlign.right,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Property'),
                      SizedBox(
                        width: 0.5.sw,
                        child: Text(
                          '${house.bedroom} Beds, ${house.bathroom} Baths, ${house.area} Sqft',
                          maxLines: 2,
                          textAlign: TextAlign.right,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Nama'),
                      Text(user.fullname),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Nomor'),
                      Text(user.phoneNumber),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Checkin'),
                      Text(formatDate(booking.checkin)),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Checkout'),
                      Text(formatDate(booking.checkout)),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Lama Menginap'),
                      SizedBox(
                        width: 0.5.sw,
                        child: Text(
                          longDays(booking.checkin, booking.checkout)
                                  .toString() +
                              ' Days',
                          maxLines: 2,
                          textAlign: TextAlign.right,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total'),
                      SizedBox(
                        width: 0.5.sw,
                        child: Text(
                          formatRupiah(booking.total.toString()),
                          maxLines: 2,
                          textAlign: TextAlign.right,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.red[400],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: Row(
                children: [
                  SizedBox(
                    width: 0.5.sw,
                    child: GestureDetector(
                      onTap: () async {
                        int bookingId = booking.id;

                        await Services.instance
                            .deleteBooking(context, bookingId);

                        Navigator.of(context).pushReplacementNamed(
                          RouterGenerator.bookingScreen,
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 1.sw,
                        height: 50.h,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: Colors.red[800],
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              // topRight: Radius.circular(15),
                            )),
                        child: Text(
                          'CANCEL',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 0.5.sw,
                    child: GestureDetector(
                      onTap: () {
                        bookingProvider.setTempPayment(booking);
                        Navigator.of(context)
                            .pushNamed(RouterGenerator.paymentScreen);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 1.sw,
                        height: 50.h,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: identityColor,
                            borderRadius: BorderRadius.only(
                              // topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            )),
                        child: Text(
                          'PAY',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Align(
            //   alignment: Alignment.bottomCenter,
            //   child: Positioned(
            //     bottom: 0,
            //     child: GestureDetector(
            //       onTap: () {
            //         bookingProvider.setTempPayment(booking);
            //         Navigator.of(context)
            //             .pushNamed(RouterGenerator.paymentScreen);
            //       },
            //       child: Container(
            //         alignment: Alignment.center,
            //         width: 1.sw,
            //         height: 50.h,
            //         padding: EdgeInsets.all(15),
            //         decoration: BoxDecoration(
            //             color: identityColor,
            //             borderRadius: BorderRadius.only(
            //               topLeft: Radius.circular(15),
            //               topRight: Radius.circular(15),
            //             )),
            //         child: Row(
            //           children: [
            //             SizedBox(
            //               width: 0.4.sw,
            //               child: Row(
            //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                 children: [
            //                   SizedBox(),
            //                   Text(
            //                     'PAY',
            //                     style: TextStyle(
            //                       color: Colors.white,
            //                       fontWeight: FontWeight.bold,
            //                     ),
            //                   ),
            //                   Icon(
            //                     Icons.arrow_forward_ios,
            //                     color: Colors.white,
            //                   ),
            //                 ],
            //               ),
            //             ),
            //             SizedBox(
            //               width: 0.4.sw,
            //               child: Row(
            //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                 children: [
            //                   SizedBox(),
            //                   Text(
            //                     'PAY',
            //                     style: TextStyle(
            //                       color: Colors.white,
            //                       fontWeight: FontWeight.bold,
            //                     ),
            //                   ),
            //                   Icon(
            //                     Icons.arrow_forward_ios,
            //                     color: Colors.white,
            //                   ),
            //                 ],
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
