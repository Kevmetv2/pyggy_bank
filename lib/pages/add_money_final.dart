import 'package:flutter/material.dart';
import 'package:pyggybank/models/group_model.dart';

class AddMoneyFinal extends StatefulWidget {
  final Group receiver;

  AddMoneyFinal({this.receiver});

  @override
  _AddMoneyFinalState createState() => _AddMoneyFinalState();
}

class _AddMoneyFinalState extends State<AddMoneyFinal> {
  final TextEditingController amountController = TextEditingController();

  int selectedCardIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F4F4),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
                padding:
                    const EdgeInsets.only(top: 30.0, left: 16.0, right: 16.0),
                child: Row(
                  children: <Widget>[
                    IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                    Text(
                      'Send Money',
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 20.0),
                    ),
                  ],
                )),
            Expanded(
              child: ListView.builder(
                  itemCount: 4,
                  itemBuilder: (BuildContext context, int index) {
                    return _getSection(index);
                  }),
            ),
//            _getReceiverSection(this.widget.receiver),
//            _getEnterAmountSection()
          ],
        ),
      ),
    );
  }

  Widget _getSection(int index) {
    switch (index) {
      case 0:
        return _getReceiverSection(widget.receiver);
        break;
      case 1:
        return _getEnterAmountSection();
      case 2:
        return _getBankCardSection();
      default:
        return _getSendSection();
    }
  }

  Widget _getReceiverSection(Group receiver) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 8.0),
            child: CircleAvatar(
              child: Text(receiver.name.substring(0, 1)),
            ),
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                receiver.name,
                style: TextStyle(fontWeight: FontWeight.w700),
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(Icons.account_balance,
                        size: 13.0, color: Color(0xFF929091)),
                  ),
                  Flexible(
                    child: Container(
                      child: Text(
                        receiver.description,
                        style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ))
        ],
      ),
    );
  }

  Widget _getEnterAmountSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(11.0))),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
                child: Text(
                  'Enter Amount',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '\$',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 30.0),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: TextField(
                          controller: amountController,
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                          decoration: InputDecoration(
                              hintText: 'Amount',
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 30.0)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getBankCardSection() {
    return Container(
//      color: Colors.yellow,
      margin: EdgeInsets.all(16.0),
//      height: 200.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Debit from',
                    style:
                        TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          Card(
            margin: EdgeInsets.all(0.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(11.0))),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ListView.builder(
                  itemCount: 2,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return _getBankCard(index);
                  }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getBankCard(int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: <Widget>[
          Image.asset(index % 2 == 0
              ? 'images/ico_logo_red.png'
              : 'images/ico_logo_blue.png'),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('XXXX XXXX XXXX 9898'),
          )),
          Radio(
            activeColor: Theme.of(context).accentColor,
            value: index,
            groupValue: selectedCardIndex,
            onChanged: (value) {
              selectedCardIndex = value;
              setState(() {});
            },
          )
        ],
      ),
    );
  }

  Widget _getSendSection() {
    return Container(
      margin: EdgeInsets.all(16.0),
      child: GestureDetector(
        onTapUp: (tapDetail) {
          Navigator.popUntil(context, ModalRoute.withName('/'));
        },
        child: Container(
          width: double.infinity,
          height: 50.0,
          decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.all(Radius.circular(11.0))),
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Text(
            'SEND',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 20.0),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}