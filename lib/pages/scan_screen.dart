import 'package:barcode_scan/barcode_scan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_string_encryption/flutter_string_encryption.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pyggybank/models/qr_model.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
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
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.offset >=
              scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        panelController.expand();
      } else if (scrollController.offset <=
              scrollController.position.minScrollExtent &&
          !scrollController.position.outOfRange) {
        panelController.anchor();
      } else {}

      panelController.hide();
      //panelController.collapse();
    });
    super.initState();
  }

  GlobalKey qrKey = GlobalKey();
  String qrtext = "";
  QRViewController controller;
  bool isValid = false;

  ///Controllers
  ScrollController scrollController;

  SlidingUpPanelController panelController = SlidingUpPanelController();
  List<String> components;
  List<String> unEncrypt;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
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
            ])),SlidingUpPanelWidget(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 15.0),
            decoration: ShapeDecoration(
              color: Colors.white,
              shadows: [
                BoxShadow(
                    blurRadius: 5.0,
                    spreadRadius: 2.0,
                    color: const Color(0x11000000))
              ],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: Row(
                    
                    children: <Widget>[
                      Icon(
                        Icons.menu,
                        size: 30,

                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 30.0,
                        ),
                      ),
                      Text(
                        "No Group Found",
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                  height: 50.0,
                ),
                Divider(
                  height: 0.5,
                  color: Colors.grey[300],
                ),
                Flexible(
                  child: Container(

                  ),
                ),
              ],
              mainAxisSize: MainAxisSize.min,
            ),
          ),
          controlHeight: 50.0,
          anchor: 0.4,
          panelController: panelController,
          onTap: () {
            ///Customize the processing logic
            if (SlidingUpPanelStatus.expanded == panelController.status) {
              panelController.collapse();
            } else {
              panelController.expand();
            }
          },
          enableOnTap: true, //Enable the onTap callback for control bar.
        )
      ],
    );
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
    final decrypted = cryptor.decrypt(components[1], key);
    unEncrypt = decrypted.toString().split(',');
    Qr_info group_info = Qr_info(
        admin: unEncrypt[0],
        groupId: unEncrypt[1],
        timestamp: DateTime.parse(unEncrypt[3]),
        limit: double.tryParse(unEncrypt[2]));
    //TODO VERIFY GROUP SITUATION IN RELATION TO APPLICATION
    isValid = true;
  }
}
