import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ScanTab extends StatefulWidget {
  @override
  _ScanTabState createState() => _ScanTabState();
}

bool isUrl(String? text) {
  // A simple regex pattern to validate URLs, you can improve it based on your needs
  final urlPattern = r'^https?:\/\/[\w-]+(\.[\w-]+)+[/#?]?.*$';
  final isUr = RegExp(urlPattern, caseSensitive: false).hasMatch(text ?? "");
  debugPrint('isURL: $isUr');
  return RegExp(urlPattern, caseSensitive: false).hasMatch(text ?? "");
}

Future<void> _launchUrl(String url) async {
  final Uri _url = Uri.parse(url);
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}

// Future<String> fetchProductInfo(String eanCode) async {
//   // Replace with the actual API endpoint and API key if needed
//   var url = Uri.parse('https://api.example.com/products/$eanCode');

//   try {
//     var response = await http.get(url);
//     if (response.statusCode == 200) {
//       // Assuming the response body is in JSON format
//       var jsonResponse = jsonDecode(response.body);
//       // Extract and return product information from the JSON response
//       // This depends on the actual API you're using
//       return jsonResponse['product_info'];
//     } else {
//       // Handle the case where the API does not return a 200 OK response
//       return "Product not found!";
//     }
//   } catch (e) {
//     // Handle any exceptions here
//     return "Failed to load product information!";
//   }
// }

class _ScanTabState extends State<ScanTab> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool isLoading = false;
  Barcode? result;
  String? productInfo;
  QRViewController? controller;

  // In order to get hot reload to work properly, need to pause the camera if the platform is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Using theme for consistent styling
    var theme = Theme.of(context) ?? ThemeData();
    
    debugPrint('theme: $theme');

    return Padding(
      padding: const EdgeInsets.all(12.0), // Add some padding around the column
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: buildQrView(
                context), // Refactor QR view into a method for better readability
          ),
          SizedBox(
              height:
                  20), // Provide some spacing between the QR view and the text
          Expanded(
            flex: 1,
            child: Center(
              child: (result != null)
                  ? buildScanResultWidget(theme)
                  : Text('Scan a code', style: theme.textTheme.headline6),
            ),
          )
        ],
      ),
    );
  }

  // Refactor QR view building into its own method
  Widget buildQrView(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Theme.of(context).primaryColor,
        borderRadius: 12,
        borderLength: 20,
        borderWidth: 10,
        cutOutSize: MediaQuery.of(context).size.width * 0.8,
      ),
    );
  }

  Widget buildScanResultWidget(ThemeData theme) {
    if (result == null) {
      return Text(
        'Scan a code',
        style: theme.textTheme.headline6,
      );
    }

    // Show the loader or product info if available
    if (isLoading) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Fetching product info...',
            style: theme.textTheme.subtitle1,
          ),
          SizedBox(height: 10),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(theme.colorScheme.primary),
          ),
        ],
      );
    }

    if (productInfo != null) {
      return Text(
        'Product Info: $productInfo',
        style: theme.textTheme.subtitle1,
      );
    }

    if (isUrl(result!.code)) {
      return InkWell(
        onTap: () => _launchUrl(result!.code!),
        child: Text(
          'Open Link: ${result!.code}',
          style: TextStyle(
            color: theme.colorScheme.secondary,
            decoration: TextDecoration.underline,
          ),
        ),
      );
    }

    // Default case for displaying barcode type and data
    return Column(
      children: [
        Text(
          'Barcode Type: ${result!.format.name}',
          style: TextStyle(
            color: theme.colorScheme.primary,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Data: ${result!.code}',
          style: theme.textTheme.bodyText2,
        ),
      ],
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) async {
      setState(() {
        result = scanData;
        // isLoading = true;
      });
    });
  }
}
