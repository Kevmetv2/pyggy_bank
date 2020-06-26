import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pyggybank/models/user.dart';


class Qr_info {
   String admin;
   String groupId;
   double limit;
   String timestamp;

  Qr_info({this.admin, this.groupId, this.limit, this.timestamp});

  Qr_info.fromJson(Map<String, dynamic> json) {
    admin = json['admin'];
    groupId = json['groupId'];
    limit = json['limit'];
    timestamp = json['timer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['admin'] = this.admin;
    data['groupId'] = this.groupId;
    data['limit'] = this.limit;
    data['timer'] = this.timestamp;
    return data;
  }
  Map toMap(Qr_info qr) {
    var data = Map<String, dynamic>();
    data['groupId'] = qr.groupId;
    data['admin'] = qr.admin;
    data['limit'] = qr.limit;

    data['timestamp'] = qr.timestamp;

    return data;
  }

  Qr_info.fromMap(Map<String, dynamic> mapData) {
    this.groupId = mapData['groupid'];
    this.groupId = mapData['admin'];

    this.timestamp = mapData['timestamp'];
    this.groupId = mapData['limit'];
  }
  /*
  @override
  String toString(){
    return " {"
  }
  */


}
final User james = User(
  uid: "user id",
  displayName: 'Gym equipment',
  photoUrl: 'https://i.pravatar.cc/150?img=5',
);
 final Qr_info current_qr = Qr_info(
  admin : james.uid,
limit:2.0,
groupId:"ajdoncsnf",
   timestamp: "17/08/22"

);