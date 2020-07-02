import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pyggybank/models/group_model.dart';
import 'package:pyggybank/models/request_model.dart';
import 'package:pyggybank/models/user.dart';
import 'package:pyggybank/pages/placeholder_screen.dart';
import 'package:pyggybank/pages/requests_screen.dart';
import 'package:pyggybank/services/repository.dart';
import 'package:pyggybank/widgets/progress.dart';
import 'package:pyggybank/widgets_group/favorite_groups.dart';
import 'package:pyggybank/widgets_group/recent_chats.dart';
import 'package:pyggybank/widgets_group/recent_groups.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GroupScreenBuild extends StatefulWidget {
  @override
  _GroupScreenBuildState createState() => _GroupScreenBuildState();
}

class _GroupScreenBuildState extends State<GroupScreenBuild> {
  int selectedIndex = 0;
  final List<String> categories = ['Groups', 'Friends', 'Requests', 'Activity'];
  var _repository = Repository();
  User currentUser;
  List<User> friends; // get Users friends from the DB
  List<Group> favoriteGroups; // get all Users favourite groups from the DB
  List<Group> allGroups; // get all Groups that belong to the user
  List<Request> money_requests; // get all money requests
  bool isLoading = false;

  void getData() async {
    FirebaseUser currentUser = await _repository.getCurrentUser();
    User user = await _repository.fetchUserDetailsById(currentUser.uid);

    setState(() {
      this.currentUser = user;
    });
    await getLists();
    setState(() {
      isLoading = true;
    });
  }

  void getLists() async {
    List<Group> allGroups =
        await _repository.fetchAllUserGroups(currentUser.uid);
    List<User> friends = await _repository.fetchAllUserFriends(currentUser.uid);
    List<Group> favoriteGroups =
        await _repository.fetchAllUserFavGroups(currentUser.uid);
    List<Request> money_requests =
        await _repository.fetchAllUserRequests(currentUser.uid);
    setState(() {
      this.favoriteGroups = favoriteGroups;
      this.friends = friends;
      this.allGroups = allGroups;
      this.money_requests = money_requests;
    });
  }

  @override
  initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(
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
                if (selectedIndex == 1)
                  RecentChats(
                    friends: friends,
                  ),
                if (selectedIndex == 2)
                  Expanded(
                    child: Requests(
                      requests: money_requests,
                    ),
                  ),
                if (selectedIndex == 3)
                  Expanded(child: PlaceHolderWidget(Colors.amberAccent)),
              ],
            ),
          )
        : circularProgress();
  }
}
