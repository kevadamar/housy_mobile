import 'package:animations/animations.dart';
import 'package:dev_mobile/providers/location_providers.dart';
import 'package:dev_mobile/utils/constants.dart';
import 'package:dev_mobile/utils/injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:dev_mobile/providers/houses_provider.dart';
import 'package:dev_mobile/utils/routes.dart';
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
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Housy',
        theme: ThemeData(
          // primarySwatch: MaterialColor(primary, swatch),
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
  }
}
