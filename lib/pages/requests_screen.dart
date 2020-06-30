import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/material.dart';
import 'package:pyggybank/models/request_model.dart';
import 'package:pyggybank/models/transaction_model.dart';
import 'package:pyggybank/models/user.dart';
import 'package:pyggybank/services/repository.dart';
import 'package:toast/toast.dart';
import 'package:giffy_dialog/giffy_dialog.dart';

//final List<String> items = List.generate(
//  20,
//  (i) => "hi $i",
//);

class Requests extends StatefulWidget {
  final List<Request> requests;
  Requests({this.requests});

  @override
  _RequestsState createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  final SlidableController slidableController = SlidableController();
  var _repository = Repository();

  User currentUser;

  void getData() async {
    FirebaseUser currentUser = await _repository.getCurrentUser();
    User user = await _repository.fetchUserDetailsById(currentUser.uid);

    setState(() {
      this.currentUser = user;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView.builder(
        itemCount: widget.requests.length,
        itemBuilder: (context, index) {
          return Slidable(
              key: ValueKey(index),
              actionPane: SlidableDrawerActionPane(),
              actionExtentRatio: 0.25,
              secondaryActions: <Widget>[
                IconSlideAction(
                  caption: 'Send',
                  color: Colors.green,
                  icon: Icons.check_box,
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (_) => AssetGiffyDialog(
                              image: Image.asset(
                                  "assets/images/pyggy_deposit.gif"),
                              title: Text(
                                'Success!',
                                style: TextStyle(
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.w600),
                              ),
                              description: Text(
                                'Your funds have been sent!',
                                textAlign: TextAlign.center,
                                style: TextStyle(),
                              ),
                              entryAnimation: EntryAnimation.BOTTOM,
                              onOkButtonPressed: () {
                                Navigator.popUntil(
                                    context, ModalRoute.withName('/'));
                              },
                            ));
//                    Toast.show("Money sent!", context,
//                        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                    setState(() {
                      TransactionM transaction = new TransactionM(
                          senderName: currentUser.displayName,
                          category: "Request",
                          receiverImg: currentUser.photoUrl,
                          amount: widget.requests[index].amount,
                          timestamp: Timestamp.now(),
                          paymentType: true);
                      _repository.createTransaction(
                          transaction, widget.requests[index].groupID);

                      _repository.addMoneyToGroup(
                          widget.requests[index].groupID,
                          widget.requests[index].amount);
                      widget.requests.removeAt(index);
                      //function to create a new transaction for that group too!
                    });
                  },
                ),
                IconSlideAction(
                  caption: 'Cancel',
                  color: Colors.red,
                  icon: Icons.cancel,
                  onTap: () {
                    widget.requests.removeAt(index);
                    Toast.show("Request cancelled", context,
                        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                    setState(() {});
                  },
                ),
              ],
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 10,
                        child: ListTile(
                          title: Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: Text(
                              widget.requests[index].groupName,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Text(
                              widget.requests[index].description,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                          trailing: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RichText(
                                text: TextSpan(
                                    text: '\$',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 15),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: widget.requests[index].amount
                                              .toString()),
                                    ]),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ));
        },
      ),
    );
  }
}
