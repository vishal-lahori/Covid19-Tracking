import 'package:flutter/material.dart';

import '../constants/constants.dart';

class SafetyPrecaution extends StatelessWidget {
  final String image;
  final String title;

  SafetyPrecaution({@required this.image, @required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      height: 100,
      decoration: kDecoration,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Image.asset(image),
          ),
          Padding(
            padding: const EdgeInsets.all(2),
            child: Text(
              title,
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
