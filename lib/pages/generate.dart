import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class GenScreen extends StatefulWidget {
  @override
  _GenState createState() => new _GenState();
}

var data2 = {"groupid": "Maria", "main": "maria", "time": "17/01/2020"};
var hello = "Maria says help";
var testdata = "testdata";
GlobalKey globalKey = new GlobalKey();

class _GenState extends State<GenScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TETSTUB"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 25.0),
            Container(
              child: Center(
                child: Text(
                  'Scan the QR code to join this group.',
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 25.0),
            Container(
              decoration: BoxDecoration(
                border: Border.all(style: BorderStyle.solid, width: 2.0),
              ),
              child: Center(
                child: RepaintBoundary(
                  key: globalKey,
                  child: Image.network(
                      "https://api.qrserver.com/v1/create-qr-code/?size=250x250&data=$hello"),
                ),
              ),
              height: 300,
              width: 300,
            ),
            SizedBox(height: 25.0),
            IconButton(
              icon: Icon(Icons.share),
              onPressed: capture_n_share,
            )
          ],
        ),
      ),
    );
  }

  Future<Uint8List> capture_n_share() async {
    try {
      RenderRepaintBoundary boundary =
          globalKey.currentContext.findRenderObject();
      var image = await boundary.toImage(pixelRatio: 3.0);
      ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
      var pngBytes = byteData.buffer.asUint8List();
      var bs64 = base64Encode(pngBytes);
      debugPrint(bs64.length.toString());
      await Share.file(
          'esys image', 'esys.png', pngBytes.buffer.asUint8List(), 'image/png',
          text: 'My optional text.');
    } catch (e) {
      print('error: $e');
    }
  }
}
