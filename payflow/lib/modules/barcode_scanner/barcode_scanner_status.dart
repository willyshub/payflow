/* 
  TODO 
  => Insight: 
    - Entender sobre os parementros no flutter. 
    - Uso do "[]" do "{}"" e etc. Uso do "this"
    - Uso do facatory. Como e porque utilizar. 

 */

import 'package:camera/camera.dart';

class BarcodeScannerStatus {
  final bool isCameraAvailable;
  final String error;
  final String barcode;

  final CameraController? controller;

  /// forma [padrão] de construir a classe.
  BarcodeScannerStatus({
    this.isCameraAvailable = false,
    this.controller,
    this.error = "",
    this.barcode = "",
  });

  /// Outra forma de construir a classe.
  factory BarcodeScannerStatus.available(CameraController controller) =>
      BarcodeScannerStatus(
        isCameraAvailable: true,
        controller: controller,
      );

  factory BarcodeScannerStatus.error(String message) =>
      BarcodeScannerStatus(error: message);

  factory BarcodeScannerStatus.barcode(String barcode) =>
      BarcodeScannerStatus(barcode: barcode);

  bool get showCamera => this.isCameraAvailable && error.isEmpty;

  bool get hasError => error.isNotEmpty;

  bool get hasBarcode => barcode.isNotEmpty;
}
