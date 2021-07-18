import 'package:flutter/material.dart';
import 'package:payflow/shared/models/boleto_model.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/widget/boleto_info/boleto_infor_widget.dart';
import 'package:payflow/shared/widget/boleto_list/boleto_list_controller.dart';
import 'package:payflow/shared/widget/boleto_list/boleto_list_widget.dart';

class ExtractPage extends StatefulWidget {
  const ExtractPage({Key? key}) : super(key: key);

  @override
  _ExtractPageState createState() => _ExtractPageState();
}

class _ExtractPageState extends State<ExtractPage> {
  final controller = BoletolistController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView (
      child: Column(
        children: [
         
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 24.0, left: 24.0, right: 24.0),
              child: Text("Meus Extratos", style: AppTextStyles.titleBoldHeading),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 24.0),
            child: Divider(
              color: AppColors.stroke,
              thickness: 1,
              height: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: BoletoListWidget(),
          ),
        ],
      ),
    );
  }
}
