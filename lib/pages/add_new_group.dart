import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pyggybank/widgets/creategroup.dart';

void main() => runApp(AddNewGroup());

class AddNewGroup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Create a group';
    return Scaffold(
      appBar: AppBar(
        title: Text(appTitle),
      ),
      backgroundColor: Color(0xFFF4F4F4),
      body: creategroup(),
    );
  }
}
