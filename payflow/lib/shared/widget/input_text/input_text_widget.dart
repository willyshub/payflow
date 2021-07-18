import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';

class InputTextWidget extends StatelessWidget {
  final String label;
  final bool numberKeyboard;
  final IconData icon;
  final String? initialValue;
  final String? Function(String?)? validador;
  final TextEditingController? controller;
  final void Function(String value) onChanged;

  const InputTextWidget({
    Key? key,
    required this.label,
    required this.icon,
    this.initialValue,
    this.validador,
    this.controller,
    required this.onChanged,
    this.numberKeyboard = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedCard(
      direction: AnimatedCardDirection.left,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Column(
          children: [
            TextFormField(
              style: AppTextStyles.input,
              controller: controller,
              validator: validador,
              onChanged: onChanged,
              keyboardType: numberKeyboard?  TextInputType.number :  TextInputType.text,
              decoration: InputDecoration(
                icon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Icon(
                        icon,
                        color: AppColors.primary,
                      ),
                    ),
                    Container(
                      width: 0,
                      height: 48.0,
                      child: VerticalDivider(
                        thickness: 1,
                        color: AppColors.stroke,
                      ),
                    ),
                  ],
                ),
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
                labelText: "$label",
                labelStyle: AppTextStyles.input,
              ),
            ),
            Divider(
              height: 1,
              thickness: 1,
              color: AppColors.stroke,
            ),
          ],
        ),
      ),
    );
  }
}
