import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Builder(
          builder: (context) => Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: 52,
                  backgroundColor: Colors.orange,
                  child: CircleAvatar(
                    radius: 50,
                  ),
                ),
                Text(
                  'Add group icon',
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
                      // otherwise.
                      if (_formKey.currentState.validate()) {
                        // If the form is valid, display a Snackbar.

                        Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text('Submitting form',
                                textAlign: TextAlign.center,
                                style: TextStyle())));
                      }
                    },
                    child: Text(
                      'Confirm',
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
