import 'dart:async';

import 'package:flutter/material.dart';
import 'package:payflow/modules/auth/auth_controller.dart';
import 'package:payflow/modules/login/login_page.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_images.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final authController = AuthController();
    authController.currentUser(context);
    return splash();
    // return FutureBuilder(
    //   future: Future.delayed(
    //     Duration(seconds: 4),
    //   ),
    //   builder: (context, time) {
    //     if (time.connectionState == ConnectionState.done) {
    //       return LoginPage();
    //     } else if (time.connectionState == ConnectionState.waiting) {
    //       return SplashPage();
    //     } else {
    //       return Material(child: Center(child: CircularProgressIndicator()));
    //     }
    //   },
    // );
  }

  Scaffold splash() {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Center(child: Image.asset(AppImages.union)),
          Center(child: Image.asset(AppImages.logoFull)),
        ],
      ),
    );
  }
}
