import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pyggybank/models/user.dart';
import 'package:pyggybank/pages/create_account.dart';
import 'package:pyggybank/pages/intro_slider.dart';
import 'package:pyggybank/pages/profile.dart';
import 'package:pyggybank/widgets/already_have_an_account.dart';
import 'package:pyggybank/widgets/input_field.dart';
import 'package:pyggybank/widgets/rounded_button.dart';
import 'package:pyggybank/widgets/rounded_password_field.dart';
import 'package:pyggybank/widgets/sign_up_background.dart';
import 'package:pyggybank/widgets/sign_up_divider.dart';
import 'package:pyggybank/widgets/social_icons.dart';

final GoogleSignIn googleSignIn = GoogleSignIn();
final usersRef = Firestore.instance.collection('users');
final timestamp = DateTime.now();
User currentUser;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isAuth = false;
  int pageIndex = 0;

  PageController pageController;
  @override
  void initState() {
    super.initState();
    pageController = PageController();
    googleSignIn.onCurrentUserChanged.listen((account) {
      handleSignIn(account);
    }, onError: (err) {
      print('Error signing in $err');
    });
    googleSignIn.signInSilently(suppressErrors: false).then((account) {
      handleSignIn(account);
    }).catchError((err) {
      print('Error signing in $err');
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  handleSignIn(GoogleSignInAccount account) async {
    if (account != null) {
//      await Navigator.push(context, MaterialPageRoute(builder: (context) => Intro()));
      await createUserInFirestore();
      setState(() {
        isAuth = true;
      });
    } else {
      setState(() {
        isAuth = false;
      });
    }
  }

  createUserInFirestore() async {
    //check if the users exists according to their id
    final GoogleSignInAccount user = googleSignIn.currentUser;

    DocumentSnapshot doc = await usersRef.document(user.id).get();
    // if user doesnt exist
    if (!doc.exists) {
//      await Navigator.push(
//          context, MaterialPageRoute(builder: (context) => Intro()));
      await Navigator.push(
          context, MaterialPageRoute(builder: (context) => Intro()));

      final username = await Navigator.push(
          context, MaterialPageRoute(builder: (context) => CreateAccount()));

      usersRef.document(user.id).setData({
        "id": user.id,
        "username": username,
        "photoUrl": user.photoUrl,
        "email": user.email,
        "displayName": user.displayName,
        "timestamp": timestamp,
      });
      doc = await usersRef.document(user.id).get();
    }
    currentUser = User.fromDocument(doc);
  }

  login() {
    googleSignIn.signIn();
  }

  logout() {
    googleSignIn.signOut();
  }

  onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  onTap(int pageIndex) {
    pageController.animateToPage(pageIndex,
        duration: Duration(milliseconds: 220), curve: Curves.easeInOut);
  }

  Scaffold buildAuthScreen() {
    return Scaffold(
      body: PageView(
        children: [
          RaisedButton(
            child: Text('logout'),
            onPressed: logout,
          ),
          Profile(),
          Intro(),
        ],
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: pageIndex,
        onTap: onTap,
        activeColor: Theme.of(context).primaryColor,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.whatshot)),
          BottomNavigationBarItem(icon: Icon(Icons.notifications_active)),
          BottomNavigationBarItem(
              icon: Icon(
            Icons.photo_camera,
            size: 35,
          )),
          BottomNavigationBarItem(icon: Icon(Icons.search)),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle)),
        ],
      ),
    );
  }

//  Scaffold buildNonAuthScreen() {
//    return Scaffold(
//      body: Container(
//        decoration: BoxDecoration(
//          gradient: LinearGradient(
//              begin: Alignment.topRight,
//              end: Alignment.bottomLeft,
//              colors: [
//                Theme.of(context).accentColor,
//                Theme.of(context).primaryColor,
//              ]),
//        ),
//        alignment: Alignment.center,
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          crossAxisAlignment: CrossAxisAlignment.center,
//          children: [
//            Text(
//              "Pyggy Bank",
//              style: TextStyle(
//                fontFamily: "Signatra",
//                fontSize: 70,
//                color: Colors.white,
//              ),
//            ),
//            GestureDetector(
//              child: Container(
//                width: 260,
//                height: 60,
//                decoration: BoxDecoration(
//                    image: DecorationImage(
//                        image: AssetImage(
//                            "assets/images/google_signin_button.png"))),
//              ),
//              onTap: () {
//                login();
//              },
//            ),
//          ],
//        ),
//      ),
//    );
//  }
  Scaffold buildNonAuthScreen() {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Sign_Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "SIGNUP",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.03),
              SvgPicture.asset(
                "assets/icons/signup.svg",
                height: size.height * 0.35,
              ),
              RoundedInputField(
                hintText: "Your Email",
                onChanged: (value) {},
              ),
              RoundedPasswordField(
                onChanged: (value) {},
              ),
              RoundedButton(
                text: "SIGNUP",
                press: () {},
              ),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                login: false,
                press: () {
//                Navigator.push(
//                  context,
//                  MaterialPageRoute(
//                    builder: (context) {
//                      return LoginScreen();
//                    },
//                  ),
//                );
                },
              ),
              OrDivider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SocalIcon(
                    iconSrc: "assets/icons/facebook.svg",
                    press: () {},
                  ),
                  SocalIcon(
                    iconSrc: "assets/icons/twitter.svg",
                    press: () {},
                  ),
                  SocalIcon(
                    iconSrc: "assets/icons/google-plus.svg",
                    press: () {
                      login();
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isAuth ? buildAuthScreen() : buildNonAuthScreen();
  }
}
