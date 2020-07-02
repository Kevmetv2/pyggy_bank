import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pyggybank/models/group_model.dart';
import 'package:pyggybank/models/transaction_model.dart';
import 'package:pyggybank/models/user.dart';



// Create a Group widget.
class creategroup extends StatefulWidget {
  @override
  creategroupState createState() {
    return creategroupState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class creategroupState extends State<creategroup> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(

      body: Container(
        padding:
        const EdgeInsets.symmetric(vertical: 14.0, horizontal: 14.0),
        child: Builder(
          builder: (context) =>
              Form(key: _formKey,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: <Widget>[
                    CircleAvatar(

                      radius: 52,
                      backgroundColor: Colors.amberAccent,

                      child: CircleAvatar(
                        radius: 50,


                      ),
                    ),


                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 20.0),
                       child: Text(
                      'Add group icon',
                      textAlign: TextAlign.center,
                    ),
                    ),

                    new ListTile(
                      leading: const Icon(Icons.group),
                      title: new TextField(
                        decoration: new InputDecoration(
                          hintText: "Group Name",
                        ),
                      ),
                    ),
                    new ListTile(
                      leading: const Icon(Icons.description),
                      title: new TextField(
                        decoration: new InputDecoration(
                          hintText: "Group Description",
                        ),

                      ),

                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: RaisedButton(
                        onPressed: () {
                          // Validate returns true if the form is valid, or false
                          // otherwise. v
                          if (_formKey.currentState.validate()) {
                            // If the form is valid, display a Snackbar.

                            Scaffold.of(context)
                                .showSnackBar(SnackBar(content: Text(
                                'Submitting form',textAlign: TextAlign.center,overflow: TextOverflow.fade,style: TextStyle() )));
                          }
                          bool isButtonPressed = false;

                          RaisedButton(
                            color: isButtonPressed ? Colors.amberAccent : Colors.grey,
                            onPressed: () {
                              setState(() {
                                isButtonPressed =!isButtonPressed;
                              }
                              );
                            },
                          );

                        },
                        child: Text('Confirm',style: TextStyle(
                            inherit: true, fontWeight: FontWeight.w500, fontSize: 16.0),
                          overflow: TextOverflow.fade,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
        ),
      ),
    );
  }
}
