import 'dart:developer';

import 'package:dev_mobile/components/custom_appbar/custom_appbar_component.dart';
import 'package:dev_mobile/providers/auth_provider.dart';
import 'package:dev_mobile/utils/api.dart';
import 'package:dev_mobile/utils/constants.dart';
import 'package:dev_mobile/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key key}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async =>
      Provider.of<AuthProvider>(context, listen: false).getUser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          routeBack: false,
          routeBackCb: RouterGenerator.homeScreen,
          isAccount: true,
        ),
        body: SafeArea(child: bodyContent()));
  }

  Widget bodyContent() => Builder(
        builder: (context) => Consumer<AuthProvider>(
          builder: (context, value, child) {
            if (value.isProcessing) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            final user = value.user;

            return Column(
              children: [
                Container(
                  width: 1.sw,
                  height: 0.3.sh,
                  child: Align(
                    alignment: Alignment.center,
                    child: user.imagePofile == null
                        ? Image.asset('./assets/images/user-icon.jpeg')
                        : Image.network(Api().baseUrlImg + user.imagePofile),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 0.1,
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10.0)
                      ],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    child: Stack(
                      children: [
                        ListView(
                          physics: BouncingScrollPhysics(),
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 0.4.sw,
                                  child: Text(
                                    'Email',
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    user.email,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 0.4.sw,
                                  child: Text(
                                    'Nama',
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    user.fullname,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 0.4.sw,
                                  child: Text(
                                    'Username',
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    user.username,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     SizedBox(
                            //       width: 0.4.sw,
                            //       child: Text(
                            //         'Gender',
                            //         style: TextStyle(
                            //           fontSize: 20.sp,
                            //         ),
                            //       ),
                            //     ),
                            //     Expanded(
                            //       child: Text(
                            //         user.gender,
                            //         maxLines: 2,
                            //         overflow: TextOverflow.ellipsis,
                            //         style: TextStyle(
                            //           fontSize: 20.sp,
                            //         ),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            // SizedBox(
                            //   height: 15.h,
                            // ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 0.4.sw,
                                  child: Text(
                                    'Nomor',
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    user.phoneNumber,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 0.4.sw,
                                  child: Text(
                                    'Alamat',
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    user.address,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: GestureDetector(
                            onTap: () => Navigator.of(context)
                                .pushNamed(RouterGenerator.editProfileScreen),
                            child: Container(
                              height: 60.h,
                              width: 1.sw,
                              decoration: BoxDecoration(
                                color: identityColor,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  topRight: Radius.circular(25),
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'EDIT PROFILE',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      );
}
