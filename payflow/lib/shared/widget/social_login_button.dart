import 'package:flutter/material.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_images.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';

class SocialLoginButton extends StatelessWidget {
  final VoidCallback onTap;
  const SocialLoginButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 56.0,
        margin: const EdgeInsets.symmetric(horizontal: 70.0),
        decoration: BoxDecoration(
          color: AppColors.shape,
          border: Border.fromBorderSide(BorderSide(
            color: AppColors.stroke,
          )),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: InkWell(
          splashColor: AppColors.primary,
          focusColor: AppColors.primary,
          hoverColor: AppColors.primary,
          highlightColor: AppColors.primary,
          onTap: () {},
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    border: BorderDirectional(
                        end: BorderSide(color: AppColors.stroke)),
                  ),
                  child: Image.asset(
                    AppImages.google,
                  ),
                ),
              ),
              Expanded(
                  flex: 4,
                  child: Text(
                    "Entrar com o Google",
                    textAlign: TextAlign.center,
                    style: AppTextStyles.buttonBoldGrey,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
