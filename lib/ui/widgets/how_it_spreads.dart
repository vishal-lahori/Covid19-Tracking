import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';

import '../constants/constants.dart';

class HowItsSpreadCard extends StatelessWidget {
  final String image;
  final String title;
  final String content;

  HowItsSpreadCard({
    @required this.image,
    @required this.title,
    @required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: EdgeInsets.all(20),
      decoration: kDecoration,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Image.asset(
              image,
              height: 150,
            ),
          ),
          AutoSizeText(
            title,
            style: TextStyle(
              fontSize: 20,
              color: Colors.orange,
            ),
            textAlign: TextAlign.center,
          ),
          Divider(),
          AutoSizeText(
            content,
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
