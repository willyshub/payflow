import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:payflow/modules/barcode_scanner/barcode_scanner_page.dart';
import 'package:payflow/modules/home/home_page.dart';
import 'package:payflow/modules/splash/splash_page.dart';
import 'modules/login/login_page.dart';
import 'shared/themes/app_colors.dart';
 
class AppWidget extends StatelessWidget {
  AppWidget() {
    //TODO: SystemChrome, DeviceOrientation, setPreferredOrientations
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Pay Flow",
      theme: ThemeData(
        primarySwatch: Colors.orange,
        primaryColor: AppColors.primary,
      ),
      initialRoute: "/splash",
      routes: {
        "/home": (context) => HomePage(),
        "/splash": (context) => SplashPage(),
        "/login": (context) => LoginPage(),
        "/barcode_scanner": (context) => BarcodeScannerPage(),
      },
      // home: SplashPage(),
      // //home: LoginPage(),
    );
  }
}
