import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pyggybank/models/group_model.dart';
import 'package:pyggybank/models/transaction_model.dart';
import 'package:pyggybank/models/user.dart';
import 'package:pyggybank/services/constants.dart';
import 'package:pyggybank/services/repository.dart';
import 'package:pyggybank/widgets/bank_card.dart';
import 'package:pyggybank/widgets/progress.dart';
import 'package:pyggybank/widgets_group/donut_card.dart';
import 'package:pyggybank/widgets_group/donut_chart.dart';
import 'package:pyggybank/widgets_group/transaction_history_group.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:pyggybank/widgets_group/users_in_group.dart';
import 'package:pyggybank/models/card_model.dart';

var data = [
  new DataPerItem('Home', 35, Colors.red),
  new DataPerItem('Food & Drink', 25, Colors.yellow),
  new DataPerItem('Hotel & Restaurant', 24, Colors.indigo),
  new DataPerItem('Travelling', 40, Colors.green),
];

var series = [
  new charts.Series(
    domainFn: (DataPerItem clickData, _) => clickData.name,
    measureFn: (DataPerItem clickData, _) => clickData.percent,
    colorFn: (DataPerItem clickData, _) => clickData.color,
    id: 'Item',
    data: data,
  ),
];

class GroupStat extends StatefulWidget {
  Group group;

  GroupStat({this.group});

  @override
  _GroupStatState createState() => _GroupStatState();
}

class _GroupStatState extends State<GroupStat> {
  List<TransactionM> transactions = [];
  List<User> members = [];
  List<Cards> cards = [];
  var _repository = new Repository();
  bool isLoading = false;

//  final List<BankCardModel> card_list = [
//    BankCardModel(
//        'assets/images/bg_red_card.png', '', cards.card_number, '08/20', 0),
//  ];

  void getTransactions() async {
    List<Cards> cards = await _repository.getGroupCard(widget.group.groupId);
    List<TransactionM> transactions =
        await _repository.fetchAllTransactionsGroup(widget.group.groupId);
    List<User> members =
        await _repository.fetchAllMembersGroup(widget.group.groupId);
    Group g = await _repository.groupById(
        widget.group.groupId); // refresh after transaction goes through.

    setState(() {
      this.transactions = transactions;
      this.members = members;
      this.widget.group = g;
      this.cards = cards;
      print(cards[0].card_number);
    });
  }

  void getData() async {
    await getTransactions();
    setState(() {
      isLoading = true;
    });
  }

  Widget _getBankCard(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(child: BankCard(card: cards[index])),
    );
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  double screenAwareSize(double size, BuildContext context) {
    return size * MediaQuery.of(context).size.height / baseHeight;
  }

  @override
  Widget build(BuildContext context) {
    final _media = MediaQuery.of(context).size;
    return isLoading
        ? Scaffold(
            backgroundColor: Theme.of(context).accentColor,
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                iconSize: 30.0,
                color: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Center(
                child: SvgPicture.asset(
                  'assets/images/word pyggybank.svg',
                  height: 40,
                ),
              ),
              elevation: 10.0,
            ),
            body: ListView(
              children: <Widget>[
                SizedBox(
                  height: 8,
                ),
                Text(
                  widget.group.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          'Available : ',
                          style: TextStyle(
                              fontFamily: "worksans",
                              color: Colors.white30,
                              fontSize: 17),
                        ),
                        Text(
                          '\$',
                          style: TextStyle(
                              fontFamily: "vistolsans",
                              fontSize: 25,
                              color: Colors.white),
                        ),
                        SizedBox(width: 13),
                        Text(
                          widget.group.balance.toString(),
                          style: TextStyle(
                              fontFamily: "sfprotext",
                              fontSize: 45,
                              color: Colors.white),
                        ),
                        SizedBox(width: 20),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 20.0),
                    child: Column(
                      children: <Widget>[
                        Center(
                          child: Container(
                            child: _getBankCard(0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                UserInGroups(
                  users: members,
                  groupID: widget.group.groupId,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Spending",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Varela",
                          ),
                        ),
                        TextSpan(
                          text: "      July 2020",
                          style: TextStyle(
                            color: Colors.grey.shade400,
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                            fontFamily: "Varela",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 15,
                    right: 20,
                    left: 20,
                  ),
                  height: screenAwareSize(
                      _media.longestSide <= 775 ? 180 : 130, context),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
//              boxShadow: [
//                BoxShadow(
//                  color: Colors.grey.shade100,
//                  blurRadius: 6,
//                  spreadRadius: 10,
//                )
//              ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 180,
                        width: 160,
                        child: DonutPieChart(
                          series,
                          animate: true,
                        ),
                      ),
                      Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 15,
                            ),
                            donutCard(Colors.indigo, "Home"),
                            donutCard(Colors.yellow, "Food & Drink"),
                            donutCard(Colors.greenAccent, "Hotel & Restaurant"),
                            donutCard(Colors.pinkAccent, "Travelling"),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: HistoryWidget(
                    transactions: transactions,
                  ),
                )
              ],
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
            ),
          )
        : circularProgress();
  }
}
