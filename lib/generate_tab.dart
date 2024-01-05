import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart'; // Barcode generation
import 'package:qr_flutter/qr_flutter.dart'; // QR code generation
import 'qr_code_manager.dart'; // Assuming this contains your QrCodeManager class

class GenerateTab extends StatefulWidget {
  @override
  _GenerateTabState createState() => _GenerateTabState();
}

class _GenerateTabState extends State<GenerateTab> {
  final QrCodeManager qrCodeManager = QrCodeManager();
  String inputData = "Hello World"; // Default data to encode
  bool useQr = true; // By default, use QR code
  String selectedTemplate = 'assets/whatsapp_icon.png';
  Color selectedColor = Colors.green; 

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              hintText: "Enter data to encode",
            ),
            onChanged: (value) => setState(() => inputData = value),
          ),
          SizedBox(height: 20),
          ToggleButtons(
            children: <Widget>[
              Icon(Icons.qr_code),
              Icon(Icons.view_week),
            ],
            onPressed: (int index) {
              setState(() {
                useQr = index == 0; // Use QR if the first button is selected
              });
            },
            isSelected: [useQr, !useQr],
          ),
          SizedBox(height: 20),
          if (useQr)
            qrCodeManager.generateQR(inputData, embeddedImagePath: selectedTemplate, qrColor: selectedColor) // Generate QR code
          else
            qrCodeManager.generateBarcode(inputData, Barcode.code128()), // Generate Barcode
        ],
      ),
    );
  }
}
