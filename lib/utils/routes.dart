import 'package:dev_mobile/models/book_now_model.dart';
import 'package:dev_mobile/models/house_model.dart';
import 'package:dev_mobile/screens/book_now/book_now_screen.dart';
import 'package:dev_mobile/screens/detail_product/detail_product_screen.dart';
import 'package:dev_mobile/screens/home/home_screen.dart';
import 'package:dev_mobile/screens/onboarding/onboarding_screen.dart';
import 'package:dev_mobile/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:dev_mobile/screens/signin/signin_screen.dart';
import 'package:dev_mobile/screens/signup/signup_screen.dart';

class RouterGenerator {
  static const onboardingScreen = "onboarding";
  static const signinScreen = "signin";
  static const signupScreen = "signup";
  static const homeScreen = "home";
  static const detailProductScreen = "detailProduct";
  static const bookNowScreen = "bookNow";
  static const splashScreen = "splash";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    final routeName = settings.name;

    switch (routeName) {
      case splashScreen:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case onboardingScreen:
        return MaterialPageRoute(builder: (_) => OnboardingScreen());
      case homeScreen:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case detailProductScreen:
        final houseArgs = args as HouseModel;
        return MaterialPageRoute(
          builder: (_) => DetailScreen(house: houseArgs),
        );
      case bookNowScreen:
        final houseIdArgs = args as BookNowModel;
        return MaterialPageRoute(
          builder: (_) => BookNowScreen(
            bookHouse: houseIdArgs,
          ),
        );
      case signinScreen:
        return MaterialPageRoute(builder: (_) => SigninScreen());
      case signupScreen:
        return MaterialPageRoute(builder: (_) => SignupScreen());
      default:
        throw ArgumentError('Routing not found!.');
    }
  }
}
