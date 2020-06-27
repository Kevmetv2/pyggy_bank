import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:pyggybank/models/qr_model.dart';

class GenScreen extends StatefulWidget {
  @override
  _GenState createState() => new _GenState();
}

String a = current_qr.limit.toString();
String b = current_qr.groupId;
String c = current_qr.timestamp.toString();
String d = current_qr.admin;

String data2 = '$d,$b,$a,$c';
var hello = "Maria says help";
var testdata = "testdata";

GlobalKey globalKey = new GlobalKey();

class _GenState extends State<GenScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: Center(
        child: Container(
          margin: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            child: Column(
              children: <Widget>[
                SizedBox(height: 45.0),
                Container(
                  child: Center(
                    child: Text(
                      "Allow others to scan this QR code to allow them to join your group",
                      style: TextStyle(
                          fontSize: 25.0, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
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
                          "https://api.qrserver.com/v1/create-qr-code/?size=250x250&data=$data2"),
                    ),
                  ),
                  height: 300,
                  width: 300,
                ),
                SizedBox(height: 25.0),
                Text("Or share it with them on other apps",
                    style: TextStyle(
                        fontSize: 25.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center),
                IconButton(
                  icon: Icon(Icons.share, size: 45, color: Color(0xffC0C0C0),),
                  onPressed: capture_n_share,
                  alignment: Alignment.center,
                )
              ],
            ),
          ),
        ),),);
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
