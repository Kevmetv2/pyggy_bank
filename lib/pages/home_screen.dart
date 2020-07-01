import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pyggybank/pages/add_money_selector.dart';
import 'package:pyggybank/pages/group_page_build_screen.dart';
import 'package:pyggybank/pages/scan_screen.dart';
import 'package:pyggybank/widgets/nav_drawer.dart';

import 'group_page_build_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}



class _HomeScreenState extends State<HomeScreen> {
//  var _repository = Repository();
//  User currentUser;
  @override
  void initState() {
    super.initState();
//    testingDB();
  }

//  void testingDB() async {
//    FirebaseUser currentUser = await _repository.getCurrentUser();
//    User user = await _repository.fetchUserDetailsById(currentUser.uid);
//
//    setState(() {
//      this.currentUser = user;
//    });
//    // Test complete
//
//    //List<User> friends = await _repository.fetchAllUserFriends(currentUser.uid);
//    //    print(friends[0].displayName);
//    //    print(friends[1].displayName);
//
//    // Test complete
//
//    //List<Group> groups = await _repository.fetchAllUserGroups(currentUser.uid);
//    //print(groups[0].name);
//
//    // Test complete
//
//    //    List<Group> groups =
//    //        await _repository.fetchAllUserFavGroups(currentUser.uid);
//    //    print(groups[0].name);
//
//    print(user.displayName);
//  }

  final List<Widget> _children = [
    GroupScreenBuild(),
    ScanScreen(),
    //PlaceHolderWidget(Colors.green),
    AddMoney(),
  ];

  int _page = 0;
//  void getData() async {
//    FirebaseUser currentUser = await _repository.getCurrentUser();
//    User user = await _repository.fetchUserDetailsById(currentUser.uid);
//    setState(() {
//      this.currentUser = user;
//    });
//  }

  void navigationTapped(int page) {
    //Animating Page
    setState(() {
      _page = page;
    });
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  void dispose() {
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      body: _children[_page],
      bottomNavigationBar: new CupertinoTabBar(
        activeColor: Colors.orange,
        items: <BottomNavigationBarItem>[
          new BottomNavigationBarItem(
              icon: new Icon(Icons.home,
                  color: (_page == 0) ? Colors.black : Colors.grey),
              title: new Container(height: 0.0),
              backgroundColor: Colors.white),
          new BottomNavigationBarItem(
              icon: new Icon(Icons.camera,
                  color: (_page == 2) ? Colors.black : Colors.grey),
              title: new Container(height: 0.0),
              backgroundColor: Colors.white),
          new BottomNavigationBarItem(
              icon: new Icon(Icons.monetization_on,
                  color: (_page == 3) ? Colors.black : Colors.grey),
              title: new Container(height: 0.0),
              backgroundColor: Colors.white),
        ],
        onTap: navigationTapped,
        currentIndex: _page,
      ),
    );
  }
}