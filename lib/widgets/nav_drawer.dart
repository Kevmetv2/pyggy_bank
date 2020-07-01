import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pyggybank/models/user.dart';
import 'package:pyggybank/pages/add_payment_page.dart';
import 'package:pyggybank/pages/home_screen.dart';
import 'package:pyggybank/pages/sign_up_screen.dart';
import 'package:pyggybank/pages/user_profile_screen.dart';
import 'package:pyggybank/services/repository.dart';
import 'package:pyggybank/widgets/progress.dart';

import '../services/repository.dart';
class NavDrawer extends StatefulWidget {
  @override
  _NavDrawer createState() {
    return new _NavDrawer();
  }

}
class _NavDrawer extends State<NavDrawer> {

  var _repository = Repository();
  User currentUser;
  bool isLoading = false;
  void getData() async {

    FirebaseUser currentUser = await _repository.getCurrentUser();

    User user = await _repository.fetchUserDetailsById(currentUser.uid);
    setState(() {
      this.currentUser = user;
      isLoading = true;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Drawer(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                color: Theme.of(context).accentColor,
              ),
              child: ListView(
                children: <Widget>[
                  DrawerHeader(
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 52,
                            backgroundColor: Colors.black,
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  NetworkImage(currentUser.photoUrl),
                            ),
                          ),
                          Text(
                            currentUser.displayName,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text(
                      'Home',
                      style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
//
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.people),
                    title: Text(
                      'Profile',
                      style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
//
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserProfileScreen(

                          currentUser_p: currentUser,
                        )));
              },
            ),
                  ListTile(
              leading: Icon(Icons.credit_card),
              title: Text(
                'Payment methods',
                style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () =>
              { Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => payment_page()))},
            ),
            Material(
                color: Theme.of(context).accentColor,
                child: Container(height: 25.0, child: ListTile())),
            ListTile(
              leading: Icon(Icons.help_outline),
              title: Text(
                'Help',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () => {},
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text(
                'Logout',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              onTap: () =>
              {
                _repository.signOut(),
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => SignUpScreen()))
              },
            ),
            SvgPicture.asset(
              'assets/images/Pyggybank centered pig and words.svg',
              height: 90,
            ),
          ],
        ),
      ),
    ):circularProgress();
  }


}
