import 'package:barcode_scan/barcode_scan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_string_encryption/flutter_string_encryption.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pyggybank/models/qr_model.dart';
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

  GlobalKey qrKey = GlobalKey();
  String qrtext = "";
  QRViewController controller;
  bool isValid = false;

  List<String> components;
  List<String> unEncrypt;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text('QR Code Scanner'),
        ),
        body: Column(children: <Widget>[
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
              child: Center(child: Text(isValid.toString()),
              ))
        ]));
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreate(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        qrtext = scanData;
        _filter_data();
      });
    });
  }

  void _filter_data() {
    components = qrtext.split(',');
    final key = components[0];
    final cryptor = new PlatformStringCryptor();
    final decrypted =  cryptor.decrypt(components[1], key);
    unEncrypt = decrypted.toString().split(',');
    Qr_info group_info = Qr_info(admin: unEncrypt[0],
        groupId: unEncrypt[1],
        timestamp: DateTime.parse(unEncrypt[3]),
        limit: double.tryParse(unEncrypt[2]));
    //TODO VERIFY GROUP SITUATION IN RELATION TO APPLICATION
    isValid = true;
  }

}

