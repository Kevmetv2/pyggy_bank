import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pyggybank/models/message_model.dart';
import 'package:pyggybank/models/user.dart';
import 'package:pyggybank/pages/chat_screen.dart';
import 'package:pyggybank/services/repository.dart';

class RecentChats extends StatefulWidget {
  final List<User> friends; // get users friends from DB
  RecentChats({this.friends});

  @override
  _RecentChatsState createState() => _RecentChatsState();
}

class _RecentChatsState extends State<RecentChats> {
  User currentUser;
  List<Message> messages;
  var _repository = Repository();

  void getData() async {
    FirebaseUser currentUser = await _repository.getCurrentUser();
    User user = await _repository.fetchUserDetailsById(currentUser.uid);

    setState(() {
      this.currentUser = user;
    });
  }

  Future<Null> getMessages(int index) async {
    String x;
    if (currentUser.uid.compareTo(widget.friends[index].uid) < 0) {
      x = currentUser.uid + widget.friends[index].uid;
    } else {
      x = widget.friends[index].uid + currentUser.uid;
    }
    print(x);
    messages = await _repository.fetchAllFriendMessages(x);
    setState(() {
      this.messages = messages;
    });

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChatScreen(
                  user: currentUser,
                  messages: messages,
                )));
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.friends != null)
      return Expanded(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            child: ListView.builder(
              itemCount: widget.friends.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () async => await getMessages(index),
                  child: Container(
                    margin: EdgeInsets.only(top: 5.0, bottom: 5.0, right: 20.0),
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            CircleAvatar(
                              radius: 35.0,
                              backgroundImage: widget == null
                                  ? NetworkImage(
                                      widget?.friends[index]?.photoUrl)
                                  : AssetImage(
                                      'assets/images/placeholder2.jpg'),
                            ),
                            SizedBox(width: 10.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  widget.friends[index].displayName,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5.0),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
//                                child: Text(
//                                  lastMessage.text,
//                                  style: TextStyle(
//                                    color: Colors.blueGrey,
//                                    fontSize: 15.0,
//                                    fontWeight: FontWeight.w600,
//                                  ),
//                                  overflow: TextOverflow.ellipsis,
//                                ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
//                          Text(
//                            '$lastMessage.time.toDate().hour' +
//                                ':' +
//                                '$lastMessage.time.toDate().minutes',
//                            style: TextStyle(
//                              color: Colors.grey,
//                              fontSize: 15.0,
//                              fontWeight: FontWeight.bold,
//                            ),
//                          ),
                            SizedBox(height: 5.0),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      );
  }
}
