import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Status Bar Color
void setStatusBar({Brightness brightness = Brightness.dark}) {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, statusBarIconBrightness: brightness));
}

/// Initialize screen util
void setupScreenUtil(BuildContext context) => ScreenUtil.init(
    BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width,
        maxHeight: MediaQuery.of(context).size.height),
    designSize: Size(360, 690),
    orientation: Orientation.portrait);
