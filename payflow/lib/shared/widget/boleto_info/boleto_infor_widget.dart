import 'package:flutter/material.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_images.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';

class BoletoInforWidget extends StatelessWidget {
  final int size;
  const BoletoInforWidget({
    Key? key,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              AppImages.logomini,
              color: AppColors.background,
              width: 56.0,
              height: 34.0,
            ),
            SizedBox(
              width: 30,
              height: 32,
              child: VerticalDivider(
                width: 1,
                thickness: 1,
                color: AppColors.background,
              ),
            ),
            Text.rich(TextSpan(
              text: "Você tem ",
              style: AppTextStyles.captionBackground,
              children: [
                TextSpan(
                  text: "$size boletos\n",
                  style: AppTextStyles.captionBoldBackground,
                ),
                TextSpan(
                  text: "cadastrados para pagar",
                  style: AppTextStyles.captionBackground,
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
