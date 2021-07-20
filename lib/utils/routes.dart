import 'package:flutter/material.dart';
import 'package:housy_mobile/screens/signin/signin_screen.dart';
import 'package:housy_mobile/screens/signup/signup_screen.dart';

class RouterGenerator {
  static const splashScreen = "splash";
  static const signinScreen = "signin";
  static const signupScreen = "signup";
  static const userScreen = "user";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    final routeName = settings.name;

    switch (routeName) {
      case signinScreen:
        return MaterialPageRoute(builder: (_) => SigninScreen());
      case signupScreen:
        return MaterialPageRoute(builder: (_) => SignupScreen());
      default:
        throw ArgumentError('Routing not found!.');
    }
  }
}
