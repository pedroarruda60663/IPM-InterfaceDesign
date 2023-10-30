import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ipm_project/presentation/buyticket_page.dart';
import 'package:ipm_project/presentation/discover_page.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRViewExample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text('Start Exploring',
            style: TextStyle(color: Colors.white)),
        centerTitle: true, // This centers the title
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                QRView(
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                  overlay: QrScannerOverlayShape(
                    borderColor: Colors.red,
                    borderRadius: 10,
                    borderLength: 30,
                    borderWidth: 10,
                    cutOutSize: 300,
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.06, // Adjust the position as per your requirement
                  child: const Text(
                    'Scan QR Code',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white, // White text color for visibility
                    ),
                  ),
                ),
                Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.07, // Adjust the position as per your requirement
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.9), // Adjust the maxWidth as needed
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10), // Adds some padding
                      child: const Text(
                        'Point your camera at the QR Code available after presenting your ticket',
                        maxLines: 3, // Adjust based on your requirement
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center, // Centers the text
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
              width: double.infinity,
              color: Colors.black87, // Setting the background color
              child: Container(
                padding: const EdgeInsets.all(8.0), // Add some padding around the text
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => BuyTicketPage()));
                  },
                  child: const Text(
                    "Haven't bought a ticket yet?\n   Click here to buy tickets",
                    style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 196, 209, 214)),
                  ),
                ),
              ))
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      //print(scanData.code);
      if (scanData.code == "StartMuseumVisit") {
        // Navigate to the desired page
        setState(() {
          Navigator.of(context).replace(
            oldRoute: ModalRoute.of(context)!,
            newRoute: MaterialPageRoute(builder: (context) => DiscoverPage()),
          );
        });
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}