import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pyggybank/models/request_model.dart';
import 'package:toast/toast.dart';

//final List<String> items = List.generate(
//  20,
//  (i) => "hi $i",
//);

class Requests extends StatefulWidget {
  final List<Request> requests;

  Requests({this.requests});

  @override
  _RequestsState createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  final SlidableController slidableController = SlidableController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView.builder(
        itemCount: widget.requests.length,
        itemBuilder: (context, index) {
          final item = widget.requests[index];
          return Slidable(
              key: ValueKey(index),
              actionPane: SlidableDrawerActionPane(),
              actionExtentRatio: 0.25,
              secondaryActions: <Widget>[
                IconSlideAction(
                  caption: 'Send',
                  color: Colors.green,
                  icon: Icons.check_box,
                  onTap: () {
                    widget.requests.removeAt(index);
                    Toast.show("Money sent!", context,
                        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                    setState(() {});
                  },
                ),
                IconSlideAction(
                  caption: 'Cancel',
                  color: Colors.red,
                  icon: Icons.cancel,
                  onTap: () {
                    widget.requests.removeAt(index);
                    Toast.show("Request cancelled", context,
                        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                    setState(() {});
                  },
                ),
              ],
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 10,
                        child: ListTile(
                          title: Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: Text(
                              widget.requests[index].groupID,
                              // should be groupId.name whenever we get it.
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Text(
                              widget.requests[index].description,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                          trailing: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RichText(
                                text: TextSpan(
                                    text: '\$',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 15),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: widget.requests[index].amount
                                              .toString()),
                                    ]),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ));
        },
      ),
    );
  }
}
