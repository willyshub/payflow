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
  final bool stopScanner;

  /// forma [padrão] de construir a classe.
  BarcodeScannerStatus({
    this.isCameraAvailable = false,
    this.error = "",
    this.barcode = "",
    this.stopScanner = false,
  });

  /// Outra forma de construir a classe.
  factory BarcodeScannerStatus.available() =>
      BarcodeScannerStatus(
        isCameraAvailable: true,
        stopScanner: false,
      );

  factory BarcodeScannerStatus.error(String message) => BarcodeScannerStatus(
        error: message,
        stopScanner: true,
      );

  factory BarcodeScannerStatus.barcode(String barcode) => BarcodeScannerStatus(
        barcode: barcode,
        stopScanner: true,
      );

  bool get showCamera => this.isCameraAvailable && error.isEmpty;

  bool get hasError => error.isNotEmpty;

  bool get hasBarcode => barcode.isNotEmpty;
}
