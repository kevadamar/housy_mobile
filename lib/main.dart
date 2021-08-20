import 'package:animations/animations.dart';
import 'package:dev_mobile/providers/auth_provider.dart';
import 'package:dev_mobile/providers/book_now_provider.dart';
import 'package:dev_mobile/providers/booking_provider.dart';
import 'package:dev_mobile/providers/history_provider.dart';
import 'package:dev_mobile/providers/location_providers.dart';
import 'package:dev_mobile/utils/constants.dart';
import 'package:dev_mobile/utils/injector.dart';
import 'package:dev_mobile/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:dev_mobile/providers/houses_provider.dart';
import 'package:dev_mobile/utils/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.p
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HousesProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LocationProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => BookNowProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => BookingProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => HistoryProvider(),
        ),
      ],
      child: LayoutBuilder(
        builder: (context, constraints) {
          SizeConfig().init(constraints);
          return ScreenUtilInit(
            designSize: Size(constraints.maxWidth, constraints.maxHeight),
            builder: () => MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Housy',
              theme: ThemeData(
                primarySwatch: MaterialColor(0xFF5a57ab, {
                  50: identityColor,
                  100: identityColor,
                  200: identityColor,
                  300: identityColor,
                  400: identityColor,
                  500: identityColor,
                  600: identityColor,
                  700: identityColor,
                  800: identityColor,
                  900: identityColor,
                }),
                // scaffoldBackgroundColor: Colors.white,
                pageTransitionsTheme: PageTransitionsTheme(
                  builders: {
                    TargetPlatform.android: SharedAxisPageTransitionsBuilder(
                      // fillColor: identityColor,
                      transitionType: SharedAxisTransitionType.vertical,
                    ),
                    TargetPlatform.iOS: SharedAxisPageTransitionsBuilder(
                      // fillColor: identityColor,
                      transitionType: SharedAxisTransitionType.vertical,
                    ),
                  },
                ),
              ),
              initialRoute: RouterGenerator.splashScreen,
              onGenerateRoute: RouterGenerator.generateRoute,
            ),
          );
        },
      ),
    );
  }
}
