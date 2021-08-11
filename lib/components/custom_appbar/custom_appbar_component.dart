import 'dart:io';

import 'package:dev_mobile/utils/constants.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends PreferredSize {
  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: setWidth(60)),
          child: Row(
            children: [
              Container(
                width: setWidth(100),
                height: setHeight(100),
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
