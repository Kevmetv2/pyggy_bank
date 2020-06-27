import 'package:flutter/material.dart';
import 'package:pyggybank/models/group_model.dart';
import 'package:pyggybank/pages/add_money_final.dart';
import 'package:pyggybank/pages/request_money_final.dart';

class AddMoney extends StatefulWidget {
  @override
  _AddMoneyState createState() => _AddMoneyState();
}

class _AddMoneyState extends State<AddMoney> {
  final TextEditingController searchController = TextEditingController();
  bool isShowSearchButton = false;
  int selectedIndex = 0;

//  List<ReceiverModel> receivers = [
//    // should be a list of groups
//    ReceiverModel('Salina', '0937110938', '1234 0000 0099 0909'),
//    ReceiverModel('Emily', '0937110938', '1234 0000 0099 0909'),
//    ReceiverModel('Nichole', '0937110938', '1234 0000 0099 0909'),
//    ReceiverModel('Jane', '0937110938', '1234 0000 0099 0909'),
//    ReceiverModel('Robert', '0937110938', '5678 0000 0099 0909'),
//  ];

  List<Group> groups = [
    Group(
      balance: 1490.92,
      name: "San Jose - Soup Kitchen",
      description: "Volunteering fund to help those in the area.",
      groupImg: "https://i.pravatar.cc/150?img=10",
      groupId: "",
      isFav: false,
      hasUnread: false,
    ),
    Group(
      balance: 1490.92,
      name: "test 2",
      description: "Volunteering fund to help those in the area.",
      groupImg: "https://i.pravatar.cc/150?img=10",
      groupId: "",
      isFav: false,
      hasUnread: false,
    ),
    Group(
      balance: 1490.92,
      name: "test1",
      description: "Volunteering fund to help those in the area.",
      groupImg: "https://i.pravatar.cc/150?img=10",
      groupId: "",
      isFav: false,
      hasUnread: false,
    ),
    Group(
      balance: 1490.92,
      name: "other",
      description: "Volunteering fund to help those in the area.",
      groupImg: "https://i.pravatar.cc/150?img=10",
      groupId: "",
      isFav: false,
      hasUnread: false,
    )
  ];

  List<Group> searchResults = [];

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
                      'Move Money',
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 20.0),
                    ),
                  ],
                )),
            _getSearchSection(),
            _getAccountTypeSection(),
            selectedIndex == 0
                ? _getContactListSection()
                : _getAccountListSection(),
          ],
        ),
      ),
    );
  }

  Widget _getAccountListSection() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Card(
                child: ListView.builder(
                    itemCount: searchController.text.isEmpty
                        ? groups.length
                        : searchResults.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _getReceiverSection(searchController.text.isEmpty
                          ? groups[index]
                          : searchResults[index]);
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getSearchSection() {
    Widget searchBar = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Container(
            padding: EdgeInsets.only(left: 8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration.collapsed(
                hintText: 'Search for your group',
              ),
              onChanged: _searchTextChanged,
            ),
          ),
        )
      ],
    );
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      height: 56.0,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(11.0))),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
          child: searchBar,
        ),
      ),
    );
  }

  Widget _getAccountTypeSection() {
    return Container(
      margin: EdgeInsets.all(16.0),
      child: Card(
        margin: EdgeInsets.all(0.0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(11.0))),
        child: Container(
          height: 60.0,
          child: Row(
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  onTapUp: (tapDetail) {
                    selectedIndex = 0;
                    setState(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        // new
                        // Where the linear gradient begins and ends
                        begin: Alignment.topRight, // new
                        end: Alignment.bottomLeft, // new
                        // Add one stop for each color.
                        // Stops should increase
                        // from 0 to 1
//                        stops: [0.0, 0.5],
                        stops: [0.0],
                        colors: selectedIndex == 0
                            ? [
                                // Colors are easy thanks to Flutter's
                                // Colors class.
//                                Color(0xFF47E497),
//                                Color(0xFF47E0D6),
                                Theme.of(context).primaryColor,
                              ]
                            : [
                                Colors.white,
                              ],
//                        [Colors.white, Colors.white],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 12.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.call_made,
                            color: selectedIndex == 0
                                ? Colors.white
                                : Color(0xFF939192),
                          ),
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Text(
                                  'Send Money',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: selectedIndex == 0
                                          ? Colors.white
                                          : Color(0xFF939192)),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTapUp: (tapDetail) {
                    selectedIndex = 1;
                    setState(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        // new
                        // Where the linear gradient begins and ends
                        begin: Alignment.topRight, // new
                        end: Alignment.bottomLeft, // new
                        // Add one stop for each color.
                        // Stops should increase
                        // from 0 to 1
                        stops: [0.0],
                        colors: selectedIndex == 1
                            ? [
                                // Colors are easy thanks to Flutter's
                                // Colors class.
                                Theme.of(context).primaryColor,
                              ]
                            : [Colors.white],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 12.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.call_received,
                            color: selectedIndex == 1
                                ? Colors.white
                                : Color(0xFF939192),
                          ),
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Text(
                                  'Request Money',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: selectedIndex == 1
                                          ? Colors.white
                                          : Color(0xFF939192)),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _getContactListSection() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Card(
                child: ListView.builder(
                    itemCount: searchController.text.isEmpty
                        ? groups.length
                        : searchResults.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _getReceiverSection(searchController.text.isEmpty
                          ? groups[index]
                          : searchResults[index]);
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getReceiverSection(Group receiver) {
    return GestureDetector(
      onTapUp: (tapDetail) {
        if (selectedIndex == 0)
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddMoneyFinal(
                        receiver: receiver,
                      )));
        if (selectedIndex == 1)
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => RequestMoneyFinal(
                        receiver: receiver,
                      )));
      },
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 8.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage(receiver.groupImg),
              ),
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  receiver.name,
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Icon(
                        Icons.info,
                        size: 13.0,
                        color: Color(0xFF929091),
                      ),
                    ),
                    Text(
                      receiver.description,
                      style: TextStyle(
                          fontSize: 14.0,
                          color: Color(
                            0xFF929091,
                          )),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }

  void _searchTextChanged(String text) {
    isShowSearchButton = text.isNotEmpty;
    searchResults = groups.where((i) {
      return i.name.toLowerCase().contains(text.toLowerCase());
    }).toList();
    setState(() {});
  }
}
