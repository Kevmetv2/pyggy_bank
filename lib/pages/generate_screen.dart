import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_string_encryption/flutter_string_encryption.dart';

import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:pyggybank/models/group_model.dart';
import 'package:pyggybank/models/qr_model.dart';
import 'package:pyggybank/models/user.dart';
import 'package:pyggybank/services/repository.dart';
import 'package:pyggybank/widgets/progress.dart';

class GenScreen extends StatefulWidget {
  @override
  _GenState createState() => new _GenState();
}
///SPLITING AND ENCRYPTING OF DATA

String b ;
String c ;
String d;
String _unecryData;
String packet;

GlobalKey globalKey = new GlobalKey();

class _GenState extends State<GenScreen> {
  final Group current_group;
  _GenState({this.current_group});
  var _repository = Repository();
  bool isLoading = false;
  void getData() async {
    FirebaseUser currentUser = await _repository.getCurrentUser();
    User user = await _repository.fetchUserDetailsById(currentUser.uid);

     b =current_group.groupId;
     c = Timestamp.now().toString();
     d = currentUser.uid;
     setState(() {
       _unecryData = '$d,$b,$c';
     });
  }
  @override
  void initState() {
    getData();
    // TODO: implement initState
    super.initState();
    initEncrypt();
  }
  @override
  Widget build(BuildContext context) {
    return    isLoading?   Scaffold(
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
              bottomRight: Radius.circular(30.0),
              bottomLeft: Radius.circular(30.0)
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
                          "https://api.qrserver.com/v1/create-qr-code/?size=250x250&data=$packet"),
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
        ),
              ),
    ): circularProgress();





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
  initEncrypt() async{
    final cryptor = new PlatformStringCryptor();

    final key = await cryptor.generateRandomKey();
    final encrypted = await cryptor.encrypt(_unecryData, key);

    setState(() {
      packet = '$key,$encrypted';

    });


  }
}
