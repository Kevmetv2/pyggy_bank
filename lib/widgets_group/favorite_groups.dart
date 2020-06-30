import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pyggybank/models/group_model.dart';
import 'package:pyggybank/pages/group_stat_screen.dart';

class FavoriteGroups extends StatelessWidget {
  final List<Group> groups;
  FavoriteGroups({this.groups});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Favorite Groups',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.more_horiz,
                  ),
                  iconSize: 30.0,
                  color: Colors.blueGrey,
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Container(
            height: 120.0,
            child: ListView.builder(
              padding: EdgeInsets.only(left: 10.0),
              scrollDirection: Axis.horizontal,
              itemCount: groups.length + 1,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return GestureDetector(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 16.0),
                          CircleAvatar(
                            radius: 20.0,
                            backgroundImage:
                                AssetImage("assets/images/icons8-plus-48.png"),
//                          AssetImage(favorites[index].photoUrl),
                          ),
                          SizedBox(height: 15.0),
                          Text(
                            "Create a group",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {},
                  );
                }
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => GroupStat(
                          group: groups[index - 1],
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 32.0,
                          backgroundImage:
                              NetworkImage(groups[index - 1].groupImg),
//                          AssetImage(favorites[index].photoUrl),
                        ),
                        SizedBox(height: 6.0),
                        Text(
                          groups[index - 1].name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
