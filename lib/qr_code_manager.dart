import 'package:barcode_widget/barcode_widget.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/material.dart';

class QrCodeManager {
  // Function to generate a QR Code Widget
  // Widget generateQR(String data) {
  //   return QrImageView(
  //     data: data,
  //     version: QrVersions.auto,
  //     size: 200.0,
  //   );
  // }

  // Function to generate a customized QR Code Widget
  Widget generateQR(String data, {
    String ?embeddedImagePath,
    Color qrColor = Colors.black, // Default QR color
    QrEyeStyle ?eyeStyle,
    QrDataModuleStyle ?dataModuleStyle,
  }) {
    return QrImageView(
      data: data,
      version: QrVersions.auto,
      size: 200.0,
      backgroundColor: Colors.white, // You can also make this customizable
      foregroundColor: qrColor,
      // Embed an image in the center of the QR code
      embeddedImage: embeddedImagePath != null ? AssetImage(embeddedImagePath) : null,
      embeddedImageStyle: QrEmbeddedImageStyle(
        // Set the color of the QR code
        color: qrColor,
        size: Size(30, 30), // Adjust the size of the embedded image if needed
      ),
      // Customize the style of the QR code's eyes
      eyeStyle: eyeStyle ?? QrEyeStyle(
        eyeShape: QrEyeShape.circle, // Choose shape: square, circle
        color: qrColor, // Color of the eyes
      ),
      // Customize the style of the QR code's data modules
      dataModuleStyle: dataModuleStyle ?? QrDataModuleStyle(
        dataModuleShape: QrDataModuleShape.square, // Choose shape: square, circle
      ),
    );
  }

  // Function to generate a Barcode Widget
  Widget generateBarcode(String data, Barcode barcodeType) {
    return BarcodeWidget(
      barcode: barcodeType, // Directly use Barcode type
      data: data, // Content
      width: 200,
      height: 80,
    );
  }
}

// Enum for barcode types - extend as needed
enum BarcodeType {
  Code128, // or any other format supported by the package
}
