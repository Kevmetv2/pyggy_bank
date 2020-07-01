import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pyggybank/models/user.dart';

class Message {
  String senderID;
  String senderName;
  Timestamp
      time; // Would usually be type DateTime or Firebase Timestamp in production apps
  String text;
  bool isLiked;
  bool unread;

  Message({
    this.senderID,
    this.senderName,
    this.time,
    this.text,
    this.isLiked,
    this.unread,
  });

  Map toMap(Message message) {
    var data = Map<String, dynamic>();
    data['senderID'] = message.senderID;
    data['senderName'] = message.senderName;
    data['time'] = message.time;
    data['text'] = message.text;
    data['isLiked'] = message.isLiked;
    data['unread'] = message.unread;
    return data;
  }

  Message.fromMap(Map<String, dynamic> mapData) {
    this.unread = mapData['unread'];
    this.time = mapData['time'];
    this.isLiked = mapData['isLiked'];
    this.text = mapData['text'];
    this.senderID = mapData['senderID'];
    this.senderName = mapData['senderName'];
  }
}
