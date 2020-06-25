import 'package:flutter/material.dart';
import 'package:pyggybank/models/transaction_model.dart';
import 'package:pyggybank/widgets_group/transaction_widget.dart';

class HistoryWidget extends StatelessWidget {
  final List<TransactionM> transactions;

  HistoryWidget({this.transactions});
//  Transaction s = new Transaction();
//  List<Transaction> db = s.getPayments();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Container(
              color: Colors.white,
              height: 22.0,
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                child: Text(
                  "History",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  color: Theme.of(context).accentColor,
                ))
          ],
        ),
        Container(
          color: Colors.white,
          child: ListView.builder(
            itemBuilder: (context, index) {
              return TransactionWidget(transactions[index]);
            },
            itemCount: transactions.length,
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
          ),
        ),
      ],
    );
  }
}
