import 'package:dev_mobile/models/history_model.dart';
import 'package:dev_mobile/models/house_model.dart';
import 'package:dev_mobile/models/user_model.dart';
import 'package:dev_mobile/providers/auth_provider.dart';
import 'package:dev_mobile/screens/detail_history/widget/status.dart';
import 'package:dev_mobile/services/services.dart';
import 'package:dev_mobile/utils/api.dart';
import 'package:dev_mobile/utils/constants.dart';
import 'package:dev_mobile/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class DetailInformation extends StatefulWidget {
  final HistoryModel history;

  const DetailInformation({Key key, @required this.history}) : super(key: key);

  @override
  _DetailInformationState createState() => _DetailInformationState();
}

class _DetailInformationState extends State<DetailInformation>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final snackBar = (String msg, int status) => SnackBar(
          content: Text(
            msg,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          elevation: 3,
          duration: Duration(
            milliseconds: 2500,
          ),
          backgroundColor: status == 200 ? Colors.green[400] : Colors.red[700],
          width: 300, // Width of the SnackBar.
          padding: EdgeInsets.symmetric(
            horizontal: 8.0, // Inner padding for SnackBar content.
          ),
          behavior: SnackBarBehavior.floating,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        );

    HouseModel house = widget.history.house;
    UserModel user = widget.history.user;

    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Flexible(
      child: Container(
        margin: EdgeInsets.only(top: 15.h),
        padding: EdgeInsets.only(
          top: 15.w,
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
              padding: EdgeInsets.only(
                  left: 12.w,
                  right: 12.w,
                  bottom: authProvider.user.role.name == 'owner' &&
                          widget.history.status == 2
                      ? 50.h
                      : 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TabBar(
                      isScrollable: true,
                      labelColor: Colors.black,
                      controller: _tabController,
                      labelStyle: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      tabs: [
                        Tab(
                          text: 'Information',
                        ),
                        Tab(
                          text: 'Bukti Pembayaran',
                        ),
                      ]),
                  Flexible(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        ListView(
                          children: [
                            SizedBox(
                              height: 20.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Status'),
                                Status(
                                  status: widget.history.status,
                                  stringStatus: widget.history.stringStatus,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Rumah'),
                                SizedBox(
                                  width: 0.5.sw,
                                  child: Text(
                                    house.name,
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
                                Text(formatDate(widget.history.checkin)),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Checkout'),
                                Text(formatDate(widget.history.checkout)),
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
                                    longDays(widget.history.checkin,
                                                widget.history.checkout)
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
                                    formatRupiah(
                                        widget.history.total.toString()),
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
                        Container(
                          margin: EdgeInsets.only(bottom: 65.h, top: 15.h),
                          child: Image.network(
                            Api().baseUrlImg + widget.history.attachment,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            if (authProvider.user.role.name == 'owner' &&
                widget.history.status == 2)
              Positioned(
                bottom: 0,
                child: Row(
                  children: [
                    SizedBox(
                      width: 0.5.sw,
                      child: GestureDetector(
                        onTap: () async {
                          String token = authProvider.token;
                          int orderId = widget.history.id;
                          int status = 0;

                          final response = await Services.instance
                              .updateStatus(orderId, status, token);
                          int statusCode = response['status'];

                          String msg = statusCode == 200
                              ? 'Success Rejected'
                              : 'Rejected Failed';

                          Navigator.of(context).pushNamedAndRemoveUntil(
                              RouterGenerator.homeAdminScreen,
                              (route) => false);

                          ScaffoldMessenger.of(context)
                              .showSnackBar(snackBar(msg, statusCode));
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 1.sw,
                          height: 50.h,
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                // topRight: Radius.circular(15),
                              )),
                          child: Text(
                            'REJECT',
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
                        onTap: () async {
                          String token = authProvider.token;
                          int orderId = widget.history.id;
                          int status = 3;

                          final response = await Services.instance
                              .updateStatus(orderId, status, token);
                          int statusCode = response['status'];

                          String msg = statusCode == 200
                              ? 'Success Approved'
                              : 'Approved Failed';

                          Navigator.of(context).pushNamedAndRemoveUntil(
                              RouterGenerator.homeAdminScreen,
                              (route) => false);

                          ScaffoldMessenger.of(context)
                              .showSnackBar(snackBar(msg, statusCode));
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 1.sw,
                          height: 50.h,
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.only(
                                // topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              )),
                          child: Text(
                            'APPROVE',
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
          ],
        ),
      ),
    );
  }
}
