import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pyggybank/models/group_model.dart';
import 'package:pyggybank/models/transaction_model.dart';
import 'package:pyggybank/models/user.dart';
import 'package:pyggybank/services/constants.dart';
import 'package:pyggybank/services/repository.dart';
import 'package:pyggybank/widgets/progress.dart';
import 'package:pyggybank/widgets_group/donut_card.dart';
import 'package:pyggybank/widgets_group/donut_chart.dart';
import 'package:pyggybank/widgets_group/transaction_history_group.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:pyggybank/widgets_group/users_in_group.dart';

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

//  TransactionM(
//      senderID: "Netflix",
//      category: "Entertainment",
//      receiverImg:
//          "https://www.iosicongallery.com/icons/netflix-2018-11-01/512.png",
//      amount: 100,
//      timestamp: Timestamp.now(),
//      paymentType: true),
//  TransactionM(
//      senderID: "Coca Cola",
//      category: "Food and Snacks",
//      receiverImg:
//          "https://seeklogo.com/images/C/Coca-Cola-logo-108E6559A3-seeklogo.com.png",
//      amount: 300,
//      timestamp: Timestamp.now(),
//      paymentType: false),
//  TransactionM(
//      senderID: "Coursera",
//      category: "Learning",
//      receiverImg:
//          "https://i.pinimg.com/originals/f7/64/15/f76415d3d9779400d610a0f089f551e5.jpg",
//      amount: 22,
//      timestamp: Timestamp.now(),
//      paymentType: true),
//  TransactionM(
//      senderID: "Random Company",
//      category: "",
//      receiverImg:
//          "https://cdn-images-1.medium.com/fit/c/200/200/1*n8a5ynNw0XqBlgwugpFrtg.png",
//      amount: 120,
//      timestamp: Timestamp.now(),
//      paymentType: false),
//  TransactionM(
//      senderID: "Netflix",
//      category: "Entertainment",
//      receiverImg:
//          "https://www.iosicongallery.com/icons/netflix-2018-11-01/512.png",
//      amount: 100,
//      timestamp: Timestamp.now(),
//      paymentType: true),
//  TransactionM(
//      senderID: "Coca Cola",
//      category: "Food and Snacks",
//      receiverImg:
//          "https://seeklogo.com/images/C/Coca-Cola-logo-108E6559A3-seeklogo.com.png",
//      amount: 300,
//      timestamp: Timestamp.now(),
//      paymentType: false),
//  TransactionM(
//      senderID: "Coursera",
//      category: "Learning",
//      receiverImg:
//          "https://i.pinimg.com/originals/f7/64/15/f76415d3d9779400d610a0f089f551e5.jpg",
//      amount: 22,
//      timestamp: Timestamp.now(),
//      paymentType: true),
//  TransactionM(
//      senderID: "Random Company",
//      category: "",
//      receiverImg:
//          "https://cdn-images-1.medium.com/fit/c/200/200/1*n8a5ynNw0XqBlgwugpFrtg.png",
//      amount: 120,
//      timestamp: Timestamp.now(),
//      paymentType: false),
//  TransactionM(
//      senderID: "Netflix",
//      category: "Entertainment",
//      receiverImg:
//          "https://www.iosicongallery.com/icons/netflix-2018-11-01/512.png",
//      amount: 100,
//      timestamp: Timestamp.now(),
//      paymentType: true),
//  TransactionM(
//      senderID: "Coca Cola",
//      category: "Food and Snacks",
//      receiverImg:
//          "https://seeklogo.com/images/C/Coca-Cola-logo-108E6559A3-seeklogo.com.png",
//      amount: 300,
//      timestamp: Timestamp.now(),
//      paymentType: false),
//  TransactionM(
//      senderID: "Coursera",
//      category: "Learning",
//      receiverImg:
//          "https://i.pinimg.com/originals/f7/64/15/f76415d3d9779400d610a0f089f551e5.jpg",
//      amount: 22,
//      timestamp: Timestamp.now(),
//      paymentType: true),
//  TransactionM(
//      senderID: "Random Company",
//      category: "",
//      receiverImg:
//          "https://cdn-images-1.medium.com/fit/c/200/200/1*n8a5ynNw0XqBlgwugpFrtg.png",
//      amount: 120,
//      timestamp: Timestamp.now(),
//      paymentType: false),
//List<User> users = [
//  new User(
//      uid: "13",
//      email: "",
//      photoUrl: "https://i.pravatar.cc/150?img=18",
//      displayName: "Wevin"),
//  new User(
//      uid: "14",
//      email: "",
//      photoUrl: "https://i.pravatar.cc/150?img=19",
//      displayName: "Mevin"),
//  new User(
//      uid: "15",
//      email: "",
//      photoUrl: "https://i.pravatar.cc/150?img=20",
//      displayName: "Kevin"),
//  new User(
//      uid: "16",
//      email: "",
//      photoUrl: "https://i.pravatar.cc/150?img=21",
//      displayName: "Eleven"),
//  new User(
//      uid: "17",
//      email: "",
//      photoUrl: "https://i.pravatar.cc/150?img=28",
//      displayName: "Tevin"),
//  new User(
//      uid: "18",
//      email: "",
//      photoUrl: "https://i.pravatar.cc/150?img=23",
//      displayName: "Revin"),
//  new User(
//      uid: "19",
//      email: "",
//      photoUrl: "https://i.pravatar.cc/150?img=27",
//      displayName: "Lenin"),
//  new User(
//      uid: "20",
//      email: "",
//      photoUrl: "https://i.pravatar.cc/150?img=38",
//      displayName: "Qenin"),
//];

class GroupStat extends StatefulWidget {
  final Group group;

  GroupStat({this.group});

  @override
  _GroupStatState createState() => _GroupStatState();
}

class _GroupStatState extends State<GroupStat> {
  List<TransactionM> transactions = [];
  List<User> members = [];
  var _repository = new Repository();
  bool isLoading = false;

  void getTransactions() async {
    List<TransactionM> transactions =
        await _repository.fetchAllTransactionsGroup(widget.group.groupId);
    List<User> members =
        await _repository.fetchAllMembersGroup(widget.group.groupId);
    setState(() {
      this.transactions = transactions;
      this.members = members;
    });
  }

  void getData() async {
    await getTransactions();
    setState(() {
      isLoading = true;
    });
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
