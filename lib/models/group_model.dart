class Group {
  var balance;
  String name;
  String description;
  String groupImg;
  String groupId;

  Group({
    this.balance,
    this.name,
    this.description,
    this.groupImg,
    this.groupId,
  });

  Map toMap(Group group) {
    var data = Map<String, dynamic>();
    data['balance'] = group.balance;
    data['name'] = group.name;
    data['description'] = group.description;
    data['groupImg'] = group.groupImg;
    data['groupId'] = group.groupId;
    return data;
  }

  Group.fromMap(Map<String, dynamic> mapData) {
    this.groupId = mapData['groupId'];
    this.groupImg = mapData['groupImg'];
    this.description = mapData['description'];
    this.name = mapData['name'];
    this.balance = mapData['balance'];
  }
}
