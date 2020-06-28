import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionM {
  String senderID;
  String category;
  String receiverImg;
  double amount;
  Timestamp timestamp;
  bool paymentType;

  // payment false is sending money i.e negative
  // payment true  is receiving money i.e positive

  TransactionM({
    this.senderID,
    this.category,
    this.receiverImg,
    this.amount,
    this.timestamp,
    this.paymentType,
  });

  Map toMap(TransactionM transaction) {
    var data = Map<String, dynamic>();

    data['senderID'] = transaction.senderID;
    data['category'] = transaction.category;
    data['receiverImg'] = transaction.receiverImg;
    data['amount'] = transaction.amount;
    data['timestamp'] = transaction.timestamp;
    data['paymentType'] = transaction.paymentType;
    return data;
  }

  TransactionM.fromMap(Map<String, dynamic> mapData) {
    this.senderID = mapData['email'];
    this.category = mapData['photoUrl'];
    this.receiverImg = mapData['displayName'];
    this.amount = mapData['amount'];
    this.timestamp = mapData['timestamp'];
    this.paymentType = mapData['paymentType'];
  }
}
