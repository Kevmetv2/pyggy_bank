import 'package:flutter/material.dart';
import 'package:pyggybank/models/group_model.dart';
import 'package:pyggybank/models/request_model.dart';
import 'package:pyggybank/pages/placeholder_screen.dart';
import 'package:pyggybank/pages/requests_screen.dart';
import 'package:pyggybank/widgets_group/favorite_groups.dart';
import 'package:pyggybank/widgets_group/recent_chats.dart';
import 'package:pyggybank/widgets_group/recent_groups.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

List<Request> money_requests = [
  Request(
      amount: 22.32,
      groupID: "Dancing Lessons",
      userID: "",
      description: "for Tacos"),
  Request(
      amount: 25.32,
      groupID: "SunnyVale Tennis Club",
      userID: "",
      description: "for Pizza"),
  Request(
      amount: 26.32,
      groupID: "Savings",
      userID: "",
      description: "for Burgers"),
  Request(
      amount: 28.32,
      groupID: "UCB Film Club",
      userID: "",
      description: "for Noodles"),
  Request(
      amount: 29.32,
      groupID: "Gym Equipment",
      userID: "",
      description: "for Falafel's"),
  Request(
      amount: 122.32, groupID: "Other", userID: "", description: "Onion Rings"),
];

class GroupScreenBuild extends StatefulWidget {
  @override
  _GroupScreenBuildState createState() => _GroupScreenBuildState();
}

class _GroupScreenBuildState extends State<GroupScreenBuild> {
  int selectedIndex = 0;
  final List<String> categories = ['Groups', 'Friends', 'Requests', 'Activity'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          iconSize: 30.0,
          color: Colors.white,
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
//        title: Text(
//          'Pyggy Banks',
//          textAlign: TextAlign.center,
//          style: TextStyle(
//              fontSize: 28.0, fontWeight: FontWeight.bold, color: Colors.white),
//        ),
        title: Center(
          child: SvgPicture.asset(
            'assets/images/word pyggybank.svg',
            height: 40,
          ),
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
//          CategorySelector(),
          Container(
            height: 90.0,
            color: Theme.of(context).primaryColor,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 30.0,
                    ),
                    child: Text(
                      categories[index],
                      style: TextStyle(
                        color: index == selectedIndex
                            ? Colors.white
                            : Colors.white60,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          if (selectedIndex == 0)
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
          if (selectedIndex == 1) RecentChats(),
          if (selectedIndex == 2)
            Expanded(
                child: Requests(
              requests: money_requests,
            )),
          if (selectedIndex == 3)
            Expanded(child: PlaceHolderWidget(Colors.amberAccent)),
        ],
      ),
    );
  }
}
