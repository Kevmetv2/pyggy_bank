import 'package:flutter/material.dart';
import 'package:sk_onboarding_screen/flutter_onboarding.dart';

import 'package:sk_onboarding_screen/sk_onboarding_screen.dart';

class HelpScreen extends StatefulWidget {
  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _globalKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: SKOnboardingScreen(
        bgColor: Colors.white,
        themeColor: const Color(0xFFE59938),
        pages: pages,
        skipClicked: (value) {
          Navigator.popUntil(context, ModalRoute.withName('/'));
        },
        getStartedClicked: (value) {
          Navigator.popUntil(context, ModalRoute.withName('/'));
//          print(value);
//          _globalKey.currentState.showSnackBar(SnackBar(
//            content: Text("Get Started clicked"),
//          ));
        },
      ),
    );
  }

  final pages = [
    SkOnboardingModel(
        title: 'Together',
        description:
            'Chat with your friends and community about a shared goal!',
        titleColor: Colors.black,
        descripColor: const Color(0xFF929794),
        imagePath: 'assets/images/undraw_Group_chat_unwm.png'),
    SkOnboardingModel(
        title: 'Save',
        description: 'Put your money together in a shared Pyggy Bank!',
        titleColor: Colors.black,
        descripColor: const Color(0xFF929794),
        imagePath: 'assets/images/undraw_Savings_dwkw.png'),
    SkOnboardingModel(
        title: 'Transfer',
        description:
            'Request money from your members or send money to the group',
        titleColor: Colors.black,
        descripColor: const Color(0xFF929794),
        imagePath: 'assets/images/undraw_transfer_money_rywa.png'),
    SkOnboardingModel(
        title: 'Analytics',
        description:
            'Get insights on your Pyggy Bank! See who is spending what amount and where!',
        titleColor: Colors.black,
        descripColor: const Color(0xFF929794),
        imagePath: 'assets/images/undraw_personal_goals_edgd.png'),
  ];
}
