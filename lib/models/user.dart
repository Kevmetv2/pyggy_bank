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

  User.fromMap(Map<String, dynamic> mapData) {
    this.uid = mapData['uid'];
    this.email = mapData['email'];
    this.photoUrl = mapData['photoUrl'];
    this.displayName = mapData['displayName'];
  }
}
//
//List<User> users = [
//  new User(
//      uid: "13",
//      email: "",
//      photoUrl: "https://i.pravatar.cc/150?img=18",
//      displayName: "Wevin"),
//  new User(
//      uid: "14",
//      email: "",
//      photoUrl: "https://i.pravatar.cc/150?img=19",
//      displayName: "Mevin"),
//  new User(
//      uid: "15",
//      email: "",
//      photoUrl: "https://i.pravatar.cc/150?img=20",
//      displayName: "Kevin"),
//  new User(
//      uid: "16",
//      email: "",
//      photoUrl: "https://i.pravatar.cc/150?img=21",
//      displayName: "Eleven"),
//  new User(
//      uid: "17",
//      email: "",
//      photoUrl: "https://i.pravatar.cc/150?img=28",
//      displayName: "Tevin"),
//  new User(
//      uid: "18",
//      email: "",
//      photoUrl: "https://i.pravatar.cc/150?img=23",
//      displayName: "Revin"),
//  new User(
//      uid: "19",
//      email: "",
//      photoUrl: "https://i.pravatar.cc/150?img=27",
//      displayName: "Lenin"),
//  new User(
//      uid: "20",
//      email: "",
//      photoUrl: "https://i.pravatar.cc/150?img=38",
//      displayName: "Qenin"),
//];
