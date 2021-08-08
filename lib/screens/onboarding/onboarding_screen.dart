import 'dart:async';

import 'package:dev_mobile/utils/constants.dart';
import 'package:dev_mobile/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  void _setOnBoarding() async {
    SharedPreferences _localStorage = await SharedPreferences.getInstance();
    _localStorage.setBool(
      "showBoarding",
      true,
    );
  }

  @override
  Widget build(BuildContext context) {
    setStatusBar(brightness: Brightness.light);
    return onBoardWidget(context);
  }

  Widget onBoardWidget(BuildContext context) {
    return SafeArea(
      child: IntroductionScreen(
        pages: [
          PageViewModel(
            titleWidget: Text(
              "Looking for a House",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black.withOpacity(0.7),
              ),
            ),
            bodyWidget: Text(
              "Bingung mencari rumah ? Housy aja dulu!",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
            ),
            image: Image.asset(
              'assets/images/splash1.jpg',
              width: 300,
            ),
          ),
          PageViewModel(
            titleWidget: Text(
              "Thousands of Houses",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black.withOpacity(0.7),
              ),
            ),
            bodyWidget: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                "Memberikan berbagai kemudahan dengan menghadirkan ribuan rumah dari ratusan owner",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            image: Image.asset(
              'assets/images/splash2.jpg',
              width: 230,
            ),
          ),
          PageViewModel(
            title: "Booking Now!",
            bodyWidget: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      "Booking Sekarang, menginap langsung",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _setOnBoarding();
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          RouterGenerator.homeScreen,
                          (route) => false,
                        );
                      });
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                        identityColor,
                      ),
                      overlayColor: MaterialStateProperty.all(
                        Colors.deepPurple[900],
                      ),
                      animationDuration: Duration(
                        milliseconds: 900,
                      ),
                    ),
                    child: Text(
                      'BOOK NOW!',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
            image: Image.asset(
              'assets/images/splash3.jpg',
              width: 300,
            ),
          ),
        ],
        showSkipButton: true,
        skip: Text(
          'SKIP',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        onSkip: () {
          setState(() {
            _setOnBoarding();
            Navigator.pushNamedAndRemoveUntil(
              context,
              RouterGenerator.homeScreen,
              (route) => false,
            );
          });
        },
        next: Icon(
          Icons.arrow_forward_ios,
          color: identityColor,
        ),
        doneColor: identityColor,
        dotsDecorator: DotsDecorator(
            activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            activeColor: identityColor,
            activeSize: Size(24, 10)),
        skipColor: identityColor,
        skipFlex: 0,
        nextFlex: 0,
        isProgressTap: false,
        showDoneButton: false,
      ),
    );
  }
}
