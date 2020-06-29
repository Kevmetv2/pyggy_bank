import 'package:flutter/material.dart';
import 'package:pyggybank/models/transaction_model.dart';

class TransactionWidget extends StatefulWidget {
  final TransactionM transaction;

//  const transactionWidget(
//    this.transaction, {
//    Key key,
//  }) : super(key: key);
  TransactionWidget(this.transaction);
  @override
  State<StatefulWidget> createState() => _TransactionWidgetState();
}

class _TransactionWidgetState extends State<TransactionWidget> {
  @override
  Widget build(BuildContext context) {
    TransactionM transaction = widget.transaction;
    return Container(
      padding: EdgeInsets.all(8.0),
      child: ListTile(
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                      color: Colors.pink.shade100,
                      spreadRadius: 0.1,
                      blurRadius: 25.0,
                      offset: Offset(0.0, 1.0)),
                  BoxShadow(
                      color: Colors.white,
                      spreadRadius: 0.1,
                      blurRadius: 25.0,
                      offset: Offset(0.0, 1.0))
                ],
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    transaction.receiverImg,
                    width: 50.0,
                    height: 50.0,
                  ))),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              transaction.senderName,
              style: TextStyle(
                  inherit: true, fontWeight: FontWeight.w700, fontSize: 16.0),
            ),
            Text(
                "${transaction.paymentType ? "+" : "-"} \$${transaction.amount}",
                style: TextStyle(
                    inherit: true,
                    fontWeight: FontWeight.w700,
                    fontSize: 16.0)),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(transaction.category,
                  style: TextStyle(
                      inherit: true, fontSize: 14.0, color: Colors.black45)),
              Text(
                  " ${transaction.timestamp.toDate().month} / ${transaction.timestamp.toDate().day} / ${transaction.timestamp.toDate().year}",
                  style: TextStyle(
                      inherit: true, fontSize: 15.0, color: Colors.black45)),
            ],
          ),
        ),
      ),
    );
  }
}
