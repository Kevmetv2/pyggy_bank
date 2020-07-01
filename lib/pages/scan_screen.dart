import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:pyggybank/models/group_model.dart';
import 'package:pyggybank/models/qr_model.dart';
import 'package:pyggybank/pages/user_profile_screen.dart';
import 'package:pyggybank/services/repository.dart';
import 'package:pyggybank/widgets/progress.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_code_scanner/qr_scanner_overlay_shape.dart';

class ScanScreen extends StatefulWidget {
  @override
  _ScanState createState() => new _ScanState();
}

class _ScanState extends State<ScanScreen> {
  final Group current_group;
  _ScanState({this.current_group});

  bool isLoading = false;

  Qr_info group_info;
  Group new_group_data ;
  var _repository = Repository();
  void getData() async {
    FirebaseUser currentUser = await _repository.getCurrentUser();


  }
  @override
  initState() {
    getData();
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

                      isValid ? Text("Group Found !", style: new TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)) : Text(
                          "No Group Found", style: new TextStyle(fontSize: 18)),

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

                      child: Column(

                        children: <Widget>[
                          SizedBox(
                            height: 25.0,
                          ),
                          isValid ? Container(
                              margin: EdgeInsets.all(2.0),
                              height: 360.0,
                              width: 250.0,
                              decoration: BoxDecoration(
                                color: Theme
                                    .of(context)
                                    .accentColor,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30.0),
                                    topRight: Radius.circular(30.0),
                                    bottomLeft: Radius.circular(30.0),
                                    bottomRight: Radius.circular(30.0)
                                ),
                              ),
                              child: Column(

                                mainAxisAlignment: MainAxisAlignment.center,

                                children: <Widget>[

                                  CircleAvatar(
                                    radius: 52,
                                    backgroundColor: Colors.black,
                                    child: CircleAvatar(
                                      radius: 50,
                                      backgroundImage: NetworkImage(
                                          new_group_data.groupImg),
                                    ),
                                  ),
                                  SizedBox(height: 10.0,),
                                  Text("Group name:",
                                      textAlign: TextAlign.center,
                                      style: new TextStyle(color: Colors.white,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.2)),
                                  Text(new_group_data.name,
                                      textAlign: TextAlign.center,
                                      style: new TextStyle(
                                          color: Colors.white60,
                                          fontSize: 20.0,
                                          letterSpacing: 1.2)),
                                  SizedBox(height: 10.0),
                                  Text("Group Function:",
                                      textAlign: TextAlign.center,
                                      style: new TextStyle(color: Colors.white,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.2)),
                                  Text(new_group_data.description,
                                      textAlign: TextAlign.center,
                                      style: new TextStyle(
                                          color: Colors.white60,
                                          fontSize: 20.0,

                                          letterSpacing: 1.2)),
                                  RaisedButton(onPressed: () {},
                                    child: const Text("Join Group",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1.2)),

                                  )

                                ],
                              )

                          ) :(isLoading?circularProgress(): Text(
                              "Please Scan a valid qr code to join a group")),
                        ],
                      )
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

  void _filter_data() async{
    components = qrtext.split(',');
    // final key = components[0];
    //   final cryptor = new PlatformStringCryptor();
    //final decrypted = cryptor.decrypt(components[1], key);
    //unEncrypt = decrypted.toString().split(',');
    setState(() {
      isLoading = true;
    });

    group_info = new Qr_info(
        admin: components[0],
        groupId: components[1]
    );
    _repository.authenticateGroup(group_info.groupId, group_info.admin).then((
        value) {
      if (value) {
        /// ADD TO GROUP
        /// then add to grouo
        /// and add group to them
        _repository.addtoGroup(group_info.groupId, currentUser.uid);
      } else {

      }
    });

   setState(() {
     isValid = true;
     isLoading = false;

   });
  }
}
