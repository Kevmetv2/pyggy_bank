import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';

class Intro extends StatelessWidget {
  //making list of pages needed to pass in IntroViewsFlutter constructor.
  final pages = [
    PageViewModel(
      pageColor: const Color(0xFF03A9F4),
      // iconImageAssetPath: 'assets/air-hostess.png',
      bubble: Image.asset('assets/air-hostess.png'),
      body: Text(
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit,',
      ),
      title: Text(
        'Dummy title',
      ),
      titleTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
      bodyTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
//      mainImage: Image.asset(
//        'assets/airplane.png',
//        height: 285.0,
//        width: 285.0,
//        alignment: Alignment.center,
//      ),
    ),
    PageViewModel(
      pageColor: const Color(0xFF8BC34A),
      iconImageAssetPath: 'assets/waiter.png',
      body: Text(
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, ',
      ),
      title: Text('Dummy Title'),
//      mainImage: Image.asset(
//        'assets/hotel.png',
//        height: 285.0,
//        width: 285.0,
//        alignment: Alignment.center,
//      ),
      titleTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
      bodyTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
    ),
    PageViewModel(
      pageColor: const Color(0xFF607D8B),
      iconImageAssetPath: 'assets/taxi-driver.png',
      body: Text(
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, ',
      ),
      title: Text('Dummy Title'),
//      mainImage: Image.asset(
//        'assets/taxi.png',
//        height: 285.0,
//        width: 285.0,
//        alignment: Alignment.center,
//      ),
      titleTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
      bodyTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) => IntroViewsFlutter(
          pages,
          fullTransition: 200,
          showNextButton: true,
          showBackButton: true,
          onTapDoneButton: () {
//            Navigator.push(
//              context,
//              MaterialPageRoute(
//                builder: (context) => CreateAccount(),
//              ), //MaterialPageRoute
//            );
            Navigator.pop(context);
          },
          pageButtonTextStyles: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ), //IntroViewsFlutter
      ), //Builder
    ); //Material App
  }
}
