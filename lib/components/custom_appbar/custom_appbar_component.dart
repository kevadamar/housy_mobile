import 'dart:io';

import 'package:dev_mobile/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends PreferredSize {
  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2),
          child: Row(
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
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Platform.isAndroid
                      ? Icon(
                          Icons.arrow_back,
                        )
                      : Icon(
                          Icons.arrow_back_ios,
                        ),
                ),
              ),
            ],
          )),
    );
  }
}
