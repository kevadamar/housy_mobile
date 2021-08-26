import 'dart:io';

import 'package:dev_mobile/providers/auth_provider.dart';
import 'package:dev_mobile/providers/booking_provider.dart';
import 'package:dev_mobile/providers/houses_provider.dart';
import 'package:dev_mobile/utils/constants.dart';
import 'package:dev_mobile/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomAppBar extends PreferredSize {
  final bool routeBack;
  final String routeBackCb;
  final bool isAccount;

  CustomAppBar({this.isAccount = false, this.routeBack, this.routeBackCb});

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 50.w,
              height: 50.w,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                    ),
                  ]),
              child: IconButton(
                color: identityColor,
                onPressed: () {
                  if (routeBackCb == RouterGenerator.bookingScreen) {
                    Provider.of<BookingProvider>(context, listen: false)
                        .setIniSelectedImg('');
                  }

                  routeBack
                      ? Navigator.of(context).pop()
                      : routeBackCb == RouterGenerator.homeScreen
                          ? Navigator.of(context).pushNamedAndRemoveUntil(
                              routeBackCb, (route) => false)
                          : Navigator.of(context)
                              .pushReplacementNamed(routeBackCb);
                  Provider.of<HousesProvider>(context, listen: false)
                      .setFromHome(true);
                },
                icon: Platform.isAndroid
                    ? Icon(
                        Icons.arrow_back,
                      )
                    : Icon(
                        Icons.arrow_back_ios,
                      ),
              ),
            ),
            if (isAccount)
              Container(
                width: 50.w,
                height: 50.w,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                      ),
                    ]),
                child: IconButton(
                    onPressed: () async {
                      SharedPreferences _prefs =
                          await SharedPreferences.getInstance();
                      _prefs.remove('token');
                      _prefs.remove('role');

                      Provider.of<AuthProvider>(context, listen: false)
                          .setToken(null);

                      Navigator.of(context).pushNamedAndRemoveUntil(
                          routeBackCb, (route) => false);
                    },
                    icon: Icon(
                      Icons.logout,
                      color: identityColor,
                    )),
              )
          ],
        ),
      ),
    );
  }
}
