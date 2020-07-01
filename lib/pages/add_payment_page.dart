import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pyggybank/models/card_bank_model.dart';
import 'package:pyggybank/models/user.dart';
import 'package:pyggybank/pages/add_card_page.dart';
import 'package:pyggybank/services/repository.dart';
import 'package:pyggybank/widgets/nav_drawer.dart';
import 'package:pyggybank/widgets/progress.dart';

class payment_page extends StatefulWidget {
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<payment_page> {
  int selectedCardIndex = 0;
  var _repository = Repository();
  User currentUser;
  List<card_bank> card;
  bool isLoading = false;
  bool isempty = true;

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  void getData() async {
    FirebaseUser currentUser = await _repository.getCurrentUser();
    User user = await _repository.fetchUserDetailsById(currentUser.uid);

    setState(() {
      this.currentUser = user;
    });
    await getLists();
    setState(() {
      isLoading = true;
    });
  }

  void getLists() async {
    List<card_bank> userCards = await _repository.fetchCard(currentUser.uid);
    print(userCards[0]);
    setState(() {
      this.card = userCards;
      if (card.length > 0) {
        //isempty = false;
      }
      print("test");
      print(card.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(
            backgroundColor: Theme.of(context).primaryColor,
            appBar: AppBar(
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
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    SizedBox(height: 55.0),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'Your Saved Cards',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 24.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                  width: 200,
                  child: Divider(
                    color: Colors.white,
                  ),
                ),
                isempty
                    ? Container(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("No cards have been added",
                                style: TextStyle(
                                    fontSize: 24.0,
                                    color: Colors.white60,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(height: 20.0),
                            _addbutton()
                          ],
                        ),
                      )
                    : Card(
                        margin: EdgeInsets.all(10.0),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(11.0))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: ListView.builder(
                              itemCount: card.length,
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                return _getBankCard(index);
                              }),
                        ),
                      ),
              ],
            ),
          )
        : circularProgress();
  }

  Widget _getBankCard(int index) {
    card_bank current_c = card[0];

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: <Widget>[
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('XXXX XXXX XXXX ', style: TextStyle(fontSize: 18.0)),
          ))
          //child:Text(card[index].),
        ],
      ),
    );
  }

  Widget _addbutton() {
    return Container(
        child: OutlineButton(
            color: Colors.white,
            shape: new RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => add_card_page()));
            },
            child: new Text('Add cards')));
  }
}
