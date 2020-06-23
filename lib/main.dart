import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pyggybank/pages/home_screen.dart';
import 'package:pyggybank/pages/sign_up_screen.dart';
import 'package:pyggybank/services/repository.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() {
    return new MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  var _repository = Repository();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Pyggy Bank',
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Color(0xFFa23e48),
          accentColor: Color(0xFF14213d),
          primaryIconTheme: IconThemeData(color: Colors.black),
//            primaryTextTheme: TextTheme(
//                title: TextStyle(color: Colors.black, fontFamily: "Aveny"),),
//            textTheme: TextTheme(title: TextStyle(color: Colors.black),),
        ),
        home: FutureBuilder(
          future: _repository.getCurrentUser(),
          builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
            if (snapshot.hasData) {
              return HomeScreen(); // home screen
            } else {
              return SignUpScreen(); // login screen
            }
          },
        ));
  }
}
