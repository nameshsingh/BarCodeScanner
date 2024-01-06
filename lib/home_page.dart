import 'package:flutter/material.dart';
import 'scan_tab.dart';  // Ensure this file exists and contains ScanTab widget
import 'generate_tab.dart';  // Ensure this file exists and contains GenerateTab widget

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR/Barcode Scanner & Generator'),
        bottom: TabBar(
          tabs: [
            Tab(icon: Icon(Icons.camera), text: 'Scan'),
            Tab(icon: Icon(Icons.create), text: 'Generate'),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          ScanTab(),  // UI for scanning QR/Barcodes
          GenerateTab(),  // UI for generating QR/Barcodes
        ],
      ),
    );
  }
}
