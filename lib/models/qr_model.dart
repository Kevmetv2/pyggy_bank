class Qr_info {
  String admin;
  String groupId;


  Qr_info({this.admin, this.groupId,});

  Qr_info.fromJson(Map<String, dynamic> json) {
    admin = json['admin'];
    groupId = json['groupId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['admin'] = this.admin;
    data['groupId'] = this.groupId;

    return data;
  }

  Map toMap(Qr_info qr) {
    var data = Map<String, dynamic>();
    data['groupId'] = qr.groupId;
    data['admin'] = qr.admin;

    return data;
  }

  Qr_info.fromMap(Map<String, dynamic> mapData) {
    this.groupId = mapData['groupid'];
    this.groupId = mapData['admin'];

  }
}
