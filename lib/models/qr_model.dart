import 'package:pyggybank/models/user.dart';

class Qr_info {
  String admin;
  String groupId;

  DateTime timestamp;

  Qr_info({this.admin, this.groupId, this.timestamp});

  Qr_info.fromJson(Map<String, dynamic> json) {
    admin = json['admin'];
    groupId = json['groupId'];

    timestamp = json['timer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['admin'] = this.admin;
    data['groupId'] = this.groupId;

    data['timer'] = this.timestamp;
    return data;
  }

  Map toMap(Qr_info qr) {
    var data = Map<String, dynamic>();
    data['groupId'] = qr.groupId;
    data['admin'] = qr.admin;

    data['timestamp'] = qr.timestamp;

    return data;
  }

  Qr_info.fromMap(Map<String, dynamic> mapData) {
    this.groupId = mapData['groupid'];
    this.groupId = mapData['admin'];

    this.timestamp = mapData['timestamp'];
  }
}
