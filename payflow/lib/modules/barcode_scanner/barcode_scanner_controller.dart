import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:payflow/modules/barcode_scanner/barcode_scanner_status.dart';

class BarcodeScannerController {
  BarcodeScannerStatus status = BarcodeScannerStatus();

  void getAvailableCameras() async {
    /* Verifica se existe cameras para uso e get a melhor usando qualidade máxima . */
    try {
      final response = await availableCameras();
      final camera = response.firstWhere(
          (element) => element.lensDirection == CameraLensDirection.back);
      final cameraController = CameraController(
        camera,
        ResolutionPreset.max,
        enableAudio: false,
      );
      status = BarcodeScannerStatus.available(cameraController);
    } catch (error) {
      status = BarcodeScannerStatus.error(error.toString());
    }
  }

  Future<void> scannerBarCode(InputImage inputImage) async {
    try {
      if (status.controller != null) {
        if (status.controller!.value.isStreamingImages)
          status.controller!.stopImageStream();
      }
      final barcodes = barcodesScanner.processImage(inputImage);
      var barcode;
      for (Barcode item in barcodes) {
        barcode = item.value.displayValue;
      }

      if (barcode != null && status.barcode.isEmpty) {
        status = BarcodeScannerStatus.barcode(barcode);
        status.controller!.dispose();
      } else {
        getAvailableCameras();
      }

      return;
    } catch (e) {
      print("ERRO DE LEITURA $e");
    }
  }

  void listenCamera() {
    if (status.controller!.value.isStreamingImages == false)
      status.controller!.startImageStream((cameraImage) async {
        try {
          final WriteBuffer allBytes = WriteBuffer();
          for (Plane plane in cameraImage.planes) {
            allBytes.putUint8List(plane.bytes);
          }
          final bytes = allBytes.done().buffer.asUint8List();
          final Size imageSize =
              Size(cameraImage.width.toDouble(), cameraImage.height.toDouble());
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
      });
  }
}
