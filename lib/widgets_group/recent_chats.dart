import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pyggybank/models/message_model.dart';
import 'package:pyggybank/models/user.dart';
import 'package:pyggybank/pages/chat_screen.dart';
import 'package:pyggybank/services/repository.dart';

final List<Message> lastMessages =
    []; // for each friend get their most recent message and add to last Message

class RecentChats extends StatefulWidget {
  final List<User> friends; // get users friends from DB
  RecentChats({this.friends});

  @override
  _RecentChatsState createState() => _RecentChatsState();
}

class _RecentChatsState extends State<RecentChats> {
  User currentUser;

  var _repository = Repository();

  void getData() async {
    FirebaseUser currentUser = await _repository.getCurrentUser();
    User user = await _repository.fetchUserDetailsById(currentUser.uid);

    setState(() {
      this.currentUser = user;
    });
  }

  Future<List<Message>> getMessages(String x) async {
    return _repository.fetchAllFriendMessages(x);
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
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
//              final Message lastMessage = lastMessages[
//                  index]; // query most recent message from DB for each friend_chat
              return GestureDetector(
                onTap: () async {
                  String x;
                  print(currentUser.uid);
                  setState(() {
                    if (currentUser.uid.compareTo(widget.friends[index].uid) <
                        0) {
                      x = currentUser.uid + widget.friends[index].uid;
                    } else {
                      x = widget.friends[index].uid + currentUser.uid;
                    }
                  });
                  print(x);
                  List<Message> messages = await getMessages(x);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChatScreen(
                        user: currentUser,
                        messages: messages,
                      ),
                    ),
                  );
                },
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
                            //backgroundImage: NetworkImage(widget.friends[index].photoUrl),
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
                                width: MediaQuery.of(context).size.width * 0.45,
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
