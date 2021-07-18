import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:payflow/modules/barcode_scanner/barcode_scanner_status.dart';

/* 
  Uso do async e do async*
*/

class BarcodeScannerController {
  final statusNotifier =
      ValueNotifier<BarcodeScannerStatus>(BarcodeScannerStatus());

  set status(BarcodeScannerStatus status) => statusNotifier.value = status;
  BarcodeScannerStatus get status => statusNotifier.value;

  final barcodesScanner = GoogleMlKit.vision.barcodeScanner();

  InputImage? imagePicker;

  CameraController? cameraController;

  void getAvailableCameras() async {
    /* Verifica se existe cameras para uso e get a melhor usando qualidade máxima . */
    try {
      final response = await availableCameras();
      final camera = response.firstWhere(
          (element) => element.lensDirection == CameraLensDirection.back);
      cameraController = CameraController(
        camera,
        ResolutionPreset.max,
        enableAudio: false,
      );
      await cameraController!.initialize();
      scanWithCamera();
      listenCamera();
    } catch (error) {
      status = BarcodeScannerStatus.error(error.toString());
    }
  }

  void scanWithCamera() async {
    status = BarcodeScannerStatus.available();
    Future.delayed(Duration(seconds: 20)).then((value) {
      if (status.hasBarcode == false) {
        status = BarcodeScannerStatus.error("Timeout de leitura de boleto");
      }
    });
  }

  void scanWithImagePicker() async {
    final response = await ImagePicker().getImage(source: ImageSource.gallery);
    final inputImage = InputImage.fromFilePath(response!.path);
    scannerBarCode(inputImage);
  }

  Future<void> scannerBarCode(InputImage inputImage) async {
    try {
      final barcodes = await barcodesScanner.processImage(inputImage);
      var barcode;
      for (Barcode item in barcodes) {
        barcode = item.value.displayValue;
      }

      if (barcode != null && status.barcode.isEmpty) {
        status = BarcodeScannerStatus.barcode(barcode);
        cameraController!.dispose();
        barcodesScanner.close();
      }

      return;
    } catch (e) {
      print("ERRO DE LEITURA $e");
    }
  }

  void listenCamera() {
    if (cameraController!.value.isStreamingImages == false)
      cameraController!.startImageStream((cameraImage) async {
        if (status.stopScanner == false) {
          try {
            final WriteBuffer allBytes = WriteBuffer();
            for (Plane plane in cameraImage.planes) {
              allBytes.putUint8List(plane.bytes);
            }
            final bytes = allBytes.done().buffer.asUint8List();
            final Size imageSize = Size(
                cameraImage.width.toDouble(), cameraImage.height.toDouble());
            final InputImageRotation imageRotation =
                InputImageRotation.Rotation_0deg;
            final InputImageFormat inputImageFormat =
                InputImageFormatMethods.fromRawValue(cameraImage.format.raw) ??
                    InputImageFormat.NV21;
            final planeData = cameraImage.planes.map(
              (Plane plane) {
                return InputImagePlaneMetadata(
                  bytesPerRow: plane.bytesPerRow,
                  height: plane.height,
                  width: plane.width,
                );
              },
            ).toList();

            final inputImageData = InputImageData(
              size: imageSize,
              imageRotation: imageRotation,
              inputImageFormat: inputImageFormat,
              planeData: planeData,
            );
            final inputImageCamera = InputImage.fromBytes(
                bytes: bytes, inputImageData: inputImageData);
            scannerBarCode(inputImageCamera);
          } catch (e) {
            print(e);
          }
        }
      });
  }

  void dispose() {
    statusNotifier.dispose();
    barcodesScanner.close();
    if (status.showCamera) {
      cameraController!.dispose();
    }
  }
}
