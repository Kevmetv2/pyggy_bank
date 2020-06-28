import 'package:flutter/material.dart';
import 'package:pyggybank/models/message_model.dart';
import 'package:pyggybank/models/user.dart';
import 'package:pyggybank/pages/chat_screen.dart';
import 'package:pyggybank/widgets_group/user_in_group_cards.dart';

User currentUser = new User(
    uid: "56",
    email: "",
    photoUrl: "https://i.pravatar.cc/150?img=18",
    displayName: "Other guy"); // get the user from the DB to give to the chat.

class UserInGroups extends StatefulWidget {
  final groupID;
  UserInGroups({this.groupID});
  @override
  State<StatefulWidget> createState() => _UserInGroupsState();
}

class _UserInGroupsState extends State<UserInGroups> {
  List<User> users; // get the users from the DB with the groupID.
  List<Message>
      messages; // get the messages using the groupID. to pass to the chat.

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Members",
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
              SizedBox(width: 150),
              Text(
                "To chat",
                textAlign: TextAlign.end,
                style: TextStyle(color: Colors.white),
              ),
              IconButton(
                icon: Icon(
                  Icons.chat,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChatScreen(
                                user: currentUser,
                              )));
                },
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 4.0),
          height: 130.0,
          child: ListView.builder(
            itemBuilder: (context, index) {
              if (index == 0) {
                return _addButton();
              }
              User user = users[index - 1];
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: UserWidget(
                  user: user,
                ),
              );
            },
            itemCount: users.length + 1,
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
          ),
        ),
      ],
    );
  }

  Widget _addButton() {
    return Container(
      margin: EdgeInsets.all(12.0),
      alignment: Alignment.center,
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
              color: Colors.black54, width: 0.5, style: BorderStyle.solid)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add_circle,
              color: Colors.purple,
            ),
            onPressed: () {},
            iconSize: 32.0,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              "Add Member",
              style: TextStyle(
                  inherit: true, fontWeight: FontWeight.w500, fontSize: 14.0),
              overflow: TextOverflow.fade,
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
