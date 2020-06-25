import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pyggybank/pages/group_page_build_screen.dart';
import 'package:pyggybank/pages/sign_up_screen.dart';
import 'package:pyggybank/services/repository.dart';
import 'package:pyggybank/widgets/nav-drawer.dart';

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

  void navigationTapped(int page) {
    //Animating Page
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }

  @override
  void initState() {
    super.initState();
    pageController = new PageController();
//    getData();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Pyggy Bank'),
      ),
      body: new PageView(
        children: [
          new Container(
            color: Colors.white,
            child: Row(
              children: [
                Text("Testing"),

              ],

            ),

          ),
          // menu(context),
          //dashboard(context)
//          new Container(color: Colors.white, child: SearchScreen()),
//          new Container(
//            color: Colors.white,
//            child: AddScreen(),
//          ),
//          new Container(
//              color: Colors.white, child: ActivityScreen()),
//          new Container(
//              color: Colors.white,
//              child: ProfileScreen()),
        ],
        controller: pageController,
        physics: new NeverScrollableScrollPhysics(),
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: new CupertinoTabBar(
        activeColor: Colors.orange,
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
              icon: new Icon(Icons.add_circle,
                  color: (_page == 2) ? Colors.black : Colors.grey),
              title: new Container(height: 0.0),
              backgroundColor: Colors.white),
          new BottomNavigationBarItem(
              icon: new Icon(Icons.star,
                  color: (_page == 3) ? Colors.black : Colors.grey),
              title: new Container(height: 0.0),
              backgroundColor: Colors.white),
          new BottomNavigationBarItem(
              icon: new Icon(Icons.person,
                  color: (_page == 4) ? Colors.black : Colors.grey),
              title: new Container(height: 0.0),
              backgroundColor: Colors.white),
        ],
        onTap: navigationTapped,
        currentIndex: _page,
      ),
    );
  }
}
