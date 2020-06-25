import 'package:flutter/material.dart';
import 'package:pyggybank/models/group_model.dart';
import 'package:pyggybank/widgets_group/category_selector.dart';
import 'package:pyggybank/widgets_group/favorite_groups.dart';
import 'package:pyggybank/widgets_group/recent_groups.dart';

final Group dancing = Group(
  balance: 1100.89,
  name: "Dancing Lessons",
  description: "Weekly dance lessons fund",
  groupImg: "https://i.pravatar.cc/150?img=3",
  groupId: "",
  isFav: false,
  hasUnread: true,
);
final Group gym = Group(
  balance: 1200.3,
  name: "Gym Equipment",
  description: "Fund to save for a home gym",
  groupImg: "https://i.pravatar.cc/150?img=4",
  groupId: "",
  isFav: false,
  hasUnread: true,
);
final Group savings = Group(
  balance: 1310.1,
  name: "Savings",
  description: "My personal savings group",
  groupImg: "https://i.pravatar.cc/150?img=5",
  groupId: "",
  isFav: false,
  hasUnread: false,
);
final Group tennis = Group(
  balance: 1400.32,
  name: "Sunnyvale Tennis Club",
  description: "Tennis membership costs",
  groupImg: "https://i.pravatar.cc/150?img=6",
  groupId: "",
  isFav: false,
  hasUnread: false,
);
final Group other = Group(
  balance: 1500,
  name: "Other",
  description: "Misc money",
  groupImg: "https://i.pravatar.cc/150?img=7",
  groupId: "",
  isFav: false,
  hasUnread: false,
);
final Group italy = Group(
  balance: 1290.3,
  name: "Vacation - Italy",
  description: "Savings goals for vacation",
  groupImg: "https://i.pravatar.cc/150?img=8",
  groupId: "",
  isFav: false,
  hasUnread: true,
);
final Group film = Group(
  balance: 1100.5,
  name: "UCB Film Club",
  description: "Weekly film club dues",
  groupImg: "https://i.pravatar.cc/150?img=9",
  groupId: "",
  isFav: false,
  hasUnread: false,
);
final Group soup = Group(
  balance: 1490.92,
  name: "San Jose - Soup Kitchen",
  description: "Volunteering fund to help those in the area.",
  groupImg: "https://i.pravatar.cc/150?img=10",
  groupId: "",
  isFav: false,
  hasUnread: false,
);

List<Group> favoriteGroups = [dancing, gym, savings, tennis, film];

List<Group> allGroups = [
  soup,
  italy,
  other,
  dancing,
  gym,
  savings,
  tennis,
  film
];

class GroupScreenBuild extends StatefulWidget {
  @override
  _GroupScreenBuildState createState() => _GroupScreenBuildState();
}

class _GroupScreenBuildState extends State<GroupScreenBuild> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          iconSize: 30.0,
          color: Colors.white,
          onPressed: () {Scaffold.of(context).openDrawer();},
        ),
        title: Text(
          'Pyggy Banks',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 28.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          CategorySelector(),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: Column(
                children: <Widget>[
                  FavoriteGroups(
                    groups: favoriteGroups,
                  ),
                  RecentGroups(
                    groups: allGroups,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
