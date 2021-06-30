import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:payflow/modules/login/login_controller.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_images.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/widget/social_login_button/social_login_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controller = LoginController();
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: _size.width,
        height: _size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              AppColors.primary.withOpacity(0.02),
              AppColors.primary.withOpacity(0.01),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            // background orange
            Container(
              width: _size.width,
              height: _size.height * 0.46,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(_size.height),
                    bottomRight: Radius.circular(_size.height)),
                gradient: LinearGradient(
                  colors: [
                    Colors.orange.shade900,
                    Colors.orange.shade800,
                    Colors.orange.shade700,
                    AppColors.primary,
                    AppColors.primary,
                    AppColors.primary,
                    AppColors.primary.withOpacity(0.06),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),

            // Column de items
            Positioned(
              left: 0,
              right: 0,
              top: 70.0,
              child: Column(
                children: [
                  Image.asset(
                    AppImages.person,
                    height: 373,
                    width: 208,
                  ),
                  _space20px(),
                  Image.asset(AppImages.logomini),
                  _space20px(),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 70.0,
                      right: 70.0,
                    ),
                    child: Text(
                      "Organize seus boletos em um só lugar",
                      maxLines: 3,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.titleHome,
                    ),
                  ),
                  _space20px(),
                  SocialLoginButton(
                    onTap: () async {
                      controller.googleSignIn(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox _space20px() {
    return const SizedBox(
      height: 20.0,
    );
  }
}
