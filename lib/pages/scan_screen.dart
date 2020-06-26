import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_code_scanner/qr_scanner_overlay_shape.dart';

class ScanScreen extends StatefulWidget {
  @override
  _ScanState createState() => new _ScanState();
}

class _ScanState extends State<ScanScreen> {
  ScanResult scanResult;


  @override
  initState() {
    super.initState();
  }
GlobalKey qrKey= GlobalKey();
  String qrtext =  "";
  QRViewController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: new AppBar(
      title: new Text('QR Code Scanner'),
    ),body:Column(children:<Widget>[
      Expanded(
        flex: 5,
            child: QRView(
                key: qrKey,
                overlay: QrScannerOverlayShape(
                    borderRadius: 10,
                    borderColor: Colors.red,
                    borderLength: 30,
                    borderWidth: 10,
                    cutOutSize: 300),
                onQRViewCreated: _onQRViewCreate),
          ),
          Expanded(
              flex: 1,
              child: Center(
                child: Text("Scan Result : $qrtext"),
              ))
        ]));
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreate( QRViewController controller){
    this.controller = controller;
    controller.scannedDataStream.listen((scanData){
      setState(() {
        qrtext = scanData;
      });
    });
  }

}

