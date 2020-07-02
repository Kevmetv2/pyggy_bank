import 'package:credit_card/credit_card_form.dart';
import 'package:credit_card/credit_card_model.dart';
import 'package:credit_card/credit_card_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pyggybank/models/user.dart';
import 'package:pyggybank/services/repository.dart';
import 'package:pyggybank/widgets/nav_drawer.dart';

import 'add_payment_page.dart';

class add_card_page extends StatefulWidget {
  @override
  _CardState createState() => _CardState();
}

class _CardState extends State<add_card_page> {
  String CardHolder = '';
  String expire = '';
  String CardNumber = '';
  String ccv = '';
  bool isCvvFocused = false;
  User currentUser;
  var _repository = Repository();

  void getData() async {
    FirebaseUser currentUser = await _repository.getCurrentUser();
    User user = await _repository.fetchUserDetailsById(currentUser.uid);

    setState(() {
      this.currentUser = user;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
            backgroundColor: Theme.of(context).accentColor,
            leading: Builder(builder: (BuildContext context) {
              return IconButton(
                icon: Icon(Icons.menu),
                iconSize: 30.0,
                color: Colors.white,
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            }),
            title: Center(
              child: SvgPicture.asset(
                'assets/images/word pyggybank.svg',
                height: 40,
              ),
            )),
        drawer: NavDrawer(),
        body: SafeArea(
            child: Column(children: <Widget>[
          CreditCardWidget(
            cardNumber: CardNumber,
            expiryDate: expire,
            cardHolderName: CardHolder,
            cvvCode: ccv,
            showBackView: isCvvFocused,
            height: 200.0,
            width: MediaQuery.of(context).size.width,
            animationDuration: Duration(milliseconds: 1000),
          ),
          Expanded(
              child: SingleChildScrollView(
                  child: CreditCardForm(
            onCreditCardModelChange: onModelChange,
          ))),
          new OutlineButton(
              onPressed: () {
                add_card();
                final snackBar = SnackBar(content: Text('Card Submitted'));
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => payment_page()));
              },
              shape: new RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              child: Text("Save Details", style: TextStyle(color: Colors.blue)))
        ])));
  }

  void onModelChange(CreditCardModel model) {
    setState(() {
      CardNumber = model.cardNumber;
      CardHolder = model.cardHolderName;
      ccv = model.cvvCode;
      expire = model.expiryDate;
      isCvvFocused = model.isCvvFocused;
    });
  }

  void add_card() async {
    print(currentUser.uid);
    _repository.addCardtoDb(
        CardNumber, CardHolder, ccv, expire, currentUser.uid);
  }
}
