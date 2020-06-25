import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pyggybank/pages/placeHolder.dart';
import 'package:pyggybank/pages/scan.dart';
import 'package:pyggybank/services/repository.dart';
import 'package:pyggybank/widgets/nav-drawer.dart';

import 'group_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

PageController pageController;

class _HomeScreenState extends State<HomeScreen> {
  var _repository = Repository();
//  User currentUser;

  int _page = 0;

//  void getData() async {
//    FirebaseUser currentUser = await _repository.getCurrentUser();
//    User user = await _repository.fetchUserDetailsById(currentUser.uid);
//    setState(() {
//      this.currentUser = user;
//    });
//  }

  final List<Widget> _children = [
    GroupScreen(),
    PlaceHolderWidget(Colors.redAccent),
    ScanScreen(),
    PlaceHolderWidget(Colors.green),
    PlaceHolderWidget(Colors.pink)
  ];
  final PageController pageController = new PageController();

  void navigationTapped(int page) {
    //Animating Page
    setState(() {
      _page = page;
    });
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return Scaffold(
          drawer: NavDrawer(),
          body: _children[_page],
          bottomNavigationBar: new CupertinoTabBar(
            items: <BottomNavigationBarItem>[
              new BottomNavigationBarItem(
                  icon: new Icon(Icons.home,
                      color: (_page == 0) ? Colors.black : Colors.grey),
                  title: new Container(height: 0.0),
                  backgroundColor: Colors.white),
              new BottomNavigationBarItem(
                  icon: new Icon(Icons.search,
                      color: (_page == 1) ? Colors.black : Colors.grey),
                  title: new Container(height: 0.0),
                  backgroundColor: Colors.white),
              new BottomNavigationBarItem(
                  icon: new Icon(Icons.camera,
                      color: (_page == 2) ? Colors.black : Colors.grey),
                  title: new Container(height: 0.0),
                  backgroundColor: Colors.white),
              new BottomNavigationBarItem(
                  icon: new Icon(Icons.add_circle_outline,
                      color: (_page == 3) ? Colors.black : Colors.grey),
                  title: new Container(height: 0.0),
                  backgroundColor: Colors.white),
              new BottomNavigationBarItem(
                  icon: new Icon(Icons.star,
                      color: (_page == 4) ? Colors.black : Colors.grey),
                  title: new Container(height: 0.0),
                  backgroundColor: Colors.white),
            ],
            onTap: navigationTapped,
            currentIndex: _page,
            activeColor: Colors.orange,
          ),
        );
      },
    );
  }
}
