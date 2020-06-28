import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pyggybank/models/user.dart';
import 'package:pyggybank/widgets/nav_drawer.dart';

User currentUser;

class UserProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.menu),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        drawer: NavDrawer(),
        backgroundColor: Theme.of(context).primaryColor,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 52,
                backgroundColor: Colors.black,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(currentUser.photoUrl),
                ),
              ),
              Text(
                currentUser.displayName,
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              Text(
                "User since ...",
                style: TextStyle(fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 30,
                width: 200,
                child: Divider(
                  color: Colors.white,
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                    SizedBox(width: 10),
                    Text(
                      currentUser.displayName,
                      style: TextStyle(fontSize: 18.0),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.remove_red_eye,
                      color: Colors.black,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "View Account Details",
                      style: TextStyle(fontSize: 18.0),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30,
                width: 200,
                child: Divider(
                  color: Colors.white,
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.phone,
                      color: Colors.black,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "+447537841643",
                      style: TextStyle(fontSize: 18.0),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.email,
                      color: Colors.black,
                    ),
                    SizedBox(width: 10),
                    Text(
//                      currentUser.email,
                      "email here",
                      style: TextStyle(fontSize: 18.0),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30,
                width: 200,
                child: Divider(
                  color: Colors.white,
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.lock_outline,
                      color: Colors.black,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Update Password",
                      style: TextStyle(fontSize: 18.0),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.phone_android,
                      color: Colors.black,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Update Phone Number",
                      style: TextStyle(fontSize: 18.0),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.alternate_email,
                      color: Colors.black,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Update Email",
                      style: TextStyle(fontSize: 18.0),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
