import 'package:flutter/material.dart';

import '../constants/constants.dart';

class ProfileCard extends StatelessWidget {
  final String avatar;
  final String name;
  final String email;

  ProfileCard({
    @required this.avatar,
    @required this.name,
    @required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: kDecoration,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: Image.asset(avatar, height: 120),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              name,
              style: TextStyle(fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              email,
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
