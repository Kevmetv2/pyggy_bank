import 'package:flutter/material.dart';
import 'package:pyggybank/pages/generate.dart';
import 'package:pyggybank/pages/sign_up_screen.dart';
import 'package:pyggybank/services/repository.dart';

import '../services/repository.dart';

class NavDrawer extends StatelessWidget {
  var _repository = Repository();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          color: Theme.of(context).primaryColor,
        ),
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'User name ',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
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
              onTap: () => {},
            ),
            ListTile(
              leading: Icon(Icons.contacts),
              title: Text(
                'Contacts',
                style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () => {Navigator.of(context).pop()},
            ),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text(
                'Favourites',
                style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () => {Navigator.of(context).pop()},
            ),
            ListTile(
              leading: Icon(Icons.message),
              title: Text(
                'Messages',
                style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () => {},
            ),
            ListTile(
              leading: Icon(Icons.archive),
              title: Text(
                'Rewards ( BRN gen screen)',
                style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () => {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => GenScreen()))
              },
            ),
            Material(
                color: Color(0xFFa23e48),
                child: Container(
                    height: 15.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(90.0)),
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.black,
                        ),
                        top: BorderSide(color: Colors.black),
                      ),
                    ),
                    child: ListTile())),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text(
                'Settings',
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
              leading: Icon(Icons.lock_outline),
              title: Text(
                'Privacy & Terms',
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
              onTap: () => {
                _repository.signOut(),
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => SignUpScreen()))
              },
            ),
          ],
        ),
      ),
    );
  }
}
