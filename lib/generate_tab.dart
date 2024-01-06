import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart'; // For Barcode generation
import 'qr_code_manager.dart'; // Your QrCodeManager class

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
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: buildContent(context),
    );
  }

  Widget buildContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        buildTitleText('Enter Data to Encode:', Theme.of(context).textTheme.headline6),
        const SizedBox(height: 10),
        buildTextInputField(context),
        const SizedBox(height: 20),
        buildTitleText('Select Code Type:', Theme.of(context).textTheme.subtitle1),
        buildToggleButtons(),
        const SizedBox(height: 30),
        buildTitleText('Generated Code:', Theme.of(context).textTheme.subtitle1),
        const SizedBox(height: 10),
        buildGeneratedCodeContainer(),
      ],
    );
  }

  Widget buildTitleText(String text, TextStyle? style) {
    return Text(text, style: style);
  }

  Widget buildTextInputField(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Enter data to encode",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        prefixIcon: Icon(Icons.input, color: Theme.of(context).colorScheme.secondary),
      ),
      onChanged: (value) => setState(() => inputData = value),
    );
  }

  Widget buildToggleButtons() {
    return ToggleButtons(
      borderRadius: BorderRadius.circular(8),
      fillColor: Theme.of(context).colorScheme.primary,
      selectedColor: Colors.white,
      onPressed: (int index) => setState(() => useQr = index == 0),
      isSelected: [useQr, !useQr],
      children: const <Widget>[
        Padding(padding: EdgeInsets.all(8.0), child: Text('QR Code')),
        Padding(padding: EdgeInsets.all(8.0), child: Text('Barcode')),
      ]
    );
  }

  Widget buildGeneratedCodeContainer() {
    return Container(
      padding: const EdgeInsets.all(10),
      color: Colors.grey[200],
      child: useQr
          ? qrCodeManager.generateQR(inputData, embeddedImagePath: selectedTemplate, qrColor: selectedColor)
          : qrCodeManager.generateBarcode(inputData, Barcode.code128()),
    );
  }
}
