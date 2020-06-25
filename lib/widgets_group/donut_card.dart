import 'package:flutter/material.dart';

Widget donutCard(Color color, String text) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: <Widget>[
      Container(
        margin: EdgeInsets.only(
          left: 0,
          top: 18,
          right: 10,
        ),
        height: 15,
        width: 15,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
      Text(
        text,
        style: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.bold,
          fontSize: 14,
          inherit: true,
        ),
        overflow: TextOverflow.ellipsis,
        softWrap: true,
      )
    ],
  );
}
