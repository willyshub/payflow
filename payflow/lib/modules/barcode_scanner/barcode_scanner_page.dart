import 'package:flutter/material.dart';
import 'package:payflow/modules/barcode_scanner/barcode_scanner_controller.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/widget/bottom_sheet/bottom_sheet_widget.dart';
import 'package:payflow/shared/widget/set_label_buttons/set_label_buttons.dart';
import 'barcode_scanner_status.dart';

/* 
  Estudar mais sobre:
    - addListener(() { })
 */

class BarcodeScannerPage extends StatefulWidget {
  const BarcodeScannerPage({Key? key}) : super(key: key);

  @override
  _BarcodeScannerPageState createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  final controller = BarcodeScannerController();

  @override
  void initState() {
    controller.getAvailableCameras();
    controller.statusNotifier.addListener(() {
      if (controller.status.hasBarcode) {
        Navigator.pushNamed(context, "/insert_boleto",
            arguments: controller.status.barcode);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO aprofundar-se em RotatedBox
    return SafeArea(
      top: true,
      bottom: true,
      left: true,
      right: true,
      child: Stack(
        children: [
          ValueListenableBuilder<BarcodeScannerStatus>(
              valueListenable: controller.statusNotifier,
              builder: (context, status, child) {
                if (status.isCameraAvailable) {
                  return Container(
                    child: controller.cameraController!.buildPreview(),
                  );
                } else {
                  return SizedBox.shrink();
                }
              }),
          RotatedBox(
            quarterTurns: 1,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.black,
                title: Text(
                  "Scaneie o código de barras do boleto.",
                  style: AppTextStyles.buttonBackground,
                ),
                centerTitle: true,
                leading: BackButton(
                  color: AppColors.background,
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: Colors.transparent,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: SetLabelButtons(
                primaryLabel: "Inserir código do boleto",
                primaryOnPressed: () {
                  Navigator.pushNamed(context, "/insert_boleto");
                },
                secondaryLabel: "Adicionar da galeria",
                secondaryOnPressed: () {},
              ),
            ),
          ),
          ValueListenableBuilder<BarcodeScannerStatus>(
              valueListenable: controller.statusNotifier,
              builder: (context, status, child) {
                if (status.hasError) {
                  return BottomSheetWidget(
                    title: "Não foi possível identificar um código de barras",
                    subtitle:
                        "Tente scannear novamente ou digite o código do seu boleto.",
                    primaryLabel: "Escanear novamente",
                    primaryOnPressed: () {
                      controller.getAvailableCameras();
                    },
                    secondaryLabel: "Digitar código",
                    secondaryOnPressed: () {
                      Navigator.pushNamed(context, "/insert_boleto");
                    },
                  );
                } else {
                  return SizedBox.shrink();
                }
              }),
        ],
      ),
    );
  }
}
