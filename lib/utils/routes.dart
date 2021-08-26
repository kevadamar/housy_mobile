import 'package:dev_mobile/components/add_edit_house/add_edit_house_component.dart';
import 'package:dev_mobile/models/booking_model.dart';
import 'package:dev_mobile/models/history_model.dart';
import 'package:dev_mobile/screens/account/account_screen.dart';
import 'package:dev_mobile/screens/detail_booking/detail_booking_screen.dart';
import 'package:dev_mobile/screens/detail_history/detail_history_screen.dart';
import 'package:dev_mobile/screens/edit_profile/edit_profile_screen.dart';
import 'package:dev_mobile/screens/history/history_screen.dart';
import 'package:dev_mobile/screens/home_admin/home_admin_screen.dart';
import 'package:dev_mobile/screens/payment/payment_screen.dart';
import 'package:dev_mobile/screens/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:dev_mobile/models/book_now_model.dart';
import 'package:dev_mobile/models/house_model.dart';
import 'package:dev_mobile/screens/book_now/book_now_screen.dart';
import 'package:dev_mobile/screens/booking/booking_screen.dart';
import 'package:dev_mobile/screens/detail_product/detail_product_screen.dart';
import 'package:dev_mobile/screens/home/home_screen.dart';
import 'package:dev_mobile/screens/onboarding/onboarding_screen.dart';
import 'package:dev_mobile/screens/splash/splash_screen.dart';
import 'package:dev_mobile/screens/signin/signin_screen.dart';
import 'package:dev_mobile/screens/signup/signup_screen.dart';

class RouterGenerator {
  static const splashScreen = "splash";
  static const onboardingScreen = "onboarding";

  static const signinScreen = "signin";
  static const signupScreen = "signup";
  static const homeScreen = "home";
  static const detailProductScreen = "detailProduct";
  static const bookNowScreen = "bookNow";
  static const bookingScreen = "booking";
  static const detailBookingScreen = "detailBooking";
  static const historyScreen = "history";
  static const paymentScreen = "payment";
  static const searchScreen = "search";
  static const detailHistoryScreen = "detailHistory";
  static const accountScreen = "account";
  static const homeAdminScreen = "homeAdmin";
  static const addEditHouseScreen = "addEditHouse";
  static const editProfileScreen = "editProfile";

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
      case bookingScreen:
        return MaterialPageRoute(builder: (_) => BookingScreen());
      case detailBookingScreen:
        final bookingArgs = args as BookingModel;
        return MaterialPageRoute(
            builder: (_) => DetailBookingScreen(
                  booking: bookingArgs,
                ));
      case detailHistoryScreen:
        final bookingArgs = args as HistoryModel;
        return MaterialPageRoute(
            builder: (_) => DetailHistoryScreen(
                  history: bookingArgs,
                ));
      case historyScreen:
        return MaterialPageRoute(builder: (_) => HistoryScreen());
      case paymentScreen:
        return MaterialPageRoute(builder: (_) => PaymentScreen());
      case searchScreen:
        return MaterialPageRoute(builder: (_) => SearchScreen());
      case accountScreen:
        return MaterialPageRoute(builder: (_) => AccountScreen());
      case homeAdminScreen:
        return MaterialPageRoute(builder: (_) => HomeAdminScreen());
      case addEditHouseScreen:
        return MaterialPageRoute(builder: (_) => AddEditHouse());
      case editProfileScreen:
        return MaterialPageRoute(builder: (_) => EditProfileScreen());
      default:
        throw ArgumentError('Routing not found!.');
    }
  }
}
