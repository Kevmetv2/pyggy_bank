import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pyggybank/models/group_model.dart';
import 'package:pyggybank/models/transaction_model.dart';
import 'package:pyggybank/models/user.dart';
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