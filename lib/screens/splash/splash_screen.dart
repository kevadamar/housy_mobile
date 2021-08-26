import 'dart:async';

import 'package:dev_mobile/providers/auth_provider.dart';
import 'package:dev_mobile/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    Timer(
      Duration(seconds: 2),
      () async {
        final SharedPreferences _local = await SharedPreferences.getInstance();

        final token = _local.get('token');
        final role = _local.get('role');

        print(_local.getBool("showBoarding"));
        print('cek');
        if (_local.getBool("showBoarding") == true) {
          if (token != null) {
            authProvider.setToken(token);
            Navigator.pushNamedAndRemoveUntil(
                context,
                role == 'tenant'
                    ? RouterGenerator.homeScreen
                    : RouterGenerator.homeAdminScreen,
                (route) => false);
          } else {
            Navigator.pushNamedAndRemoveUntil(
                context, RouterGenerator.homeScreen, (route) => false);
          }
        }
        if (_local.getBool("showBoarding") == null) {
          print("null gan");
          Navigator.pushNamedAndRemoveUntil(
              context, RouterGenerator.onboardingScreen, (route) => false);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/brand.svg',
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
