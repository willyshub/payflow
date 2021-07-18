import 'package:flutter/material.dart';
import 'package:payflow/shared/models/boleto_model.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/widget/boleto_info/boleto_infor_widget.dart';
import 'package:payflow/shared/widget/boleto_list/boleto_list_controller.dart';
import 'package:payflow/shared/widget/boleto_list/boleto_list_widget.dart';
import 'package:animated_card/animated_card.dart';

class MeusBoletosPage extends StatefulWidget {
  const MeusBoletosPage({Key? key}) : super(key: key);

  @override
  _MeusBoletosPageState createState() => _MeusBoletosPageState();
}

class _MeusBoletosPageState extends State<MeusBoletosPage> {
  final controller = BoletolistController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 40.0,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(100),
                        bottomRight: Radius.circular(100)),
                  ),
                  width: double.maxFinite,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: ValueListenableBuilder<List<BoletoModel>>(
                    valueListenable: controller.boletosNotifier,
                    builder: (context, boletos, __) {
                      return AnimatedCard(
                          direction: AnimatedCardDirection.right,
                          child: BoletoInforWidget(size: boletos.length));
                    },
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 24.0, left: 24.0, right: 24.0),
                child:
                    Text("Meus boletos", style: AppTextStyles.titleBoldHeading),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 24.0, horizontal: 24.0),
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
      ),
    );
  }
}
