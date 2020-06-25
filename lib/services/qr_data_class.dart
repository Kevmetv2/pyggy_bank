class qr_data_class {
  String groupid;
  String admin;
  String timeout;
  String limit;

  qr_data_class({this.groupid, this.admin, this.timeout, this.limit});

  qr_data_class.fromJson(Map<String, dynamic> json) {
    groupid = json['groupid'];
    admin = json['admin'];
    timeout = json['timeout'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['groupid'] = this.groupid;
    data['admin'] = this.admin;
    data['timeout'] = this.timeout;
    data['limit'] = this.limit;
    return data;
  }
}
