class User {
  String uid;
  String email;
  String photoUrl;
  String displayName;

  User({this.uid, this.email, this.photoUrl, this.displayName});

  Map toMap(User user) {
    var data = Map<String, dynamic>();
    data['uid'] = user.uid;
    data['email'] = user.email;
    data['photoUrl'] = user.photoUrl;
    data['displayName'] = user.displayName;
    return data;
  }
}
