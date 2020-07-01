class Request {
  String groupID;
  String userID;
  String description;
  String groupName;
  var amount;

  Request({
    this.amount,
    this.description,
    this.groupID,
    this.userID,
    this.groupName,
  });

  Map toMap(Request request) {
    var data = Map<String, dynamic>();

    data['groupID'] = request.groupID;
    data['userID'] = request.userID;
    data['description'] = request.description;
    data['amount'] = request.amount;
    data['groupName'] = request.groupName;

    return data;
  }

  Request.fromMap(Map<String, dynamic> mapData) {
    this.groupID = mapData['groupID'];
    this.description = mapData['description'];
    this.amount = mapData['amount'];
    this.userID = mapData['userID'];
    this.groupName = mapData['groupName'];
  }
}

//Request l = new Request(
//    amount: 22.32, groupID: "", userID: "", description: "for Tacos");
//Request l2 = new Request(
//    amount: 25.32, groupID: "", userID: "", description: "for Pizza");
//Request l3 = new Request(
//    amount: 26.32, groupID: "", userID: "", description: "for Burgers");
//Request l4 = new Request(
//    amount: 28.32, groupID: "", userID: "", description: "for Noodles");
//Request l5 = new Request(
//    amount: 29.32, groupID: "", userID: "", description: "for Falafel's");
//Request l6 = new Request(
//    amount: 122.32, groupID: "", userID: "", description: "Onion Rings");
