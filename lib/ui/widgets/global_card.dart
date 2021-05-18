import 'dart:ui';

import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

import '../screens/screens.dart';

import '../constants/constants.dart';

class GlobalCard extends StatefulWidget {
  final String icon;
  final double cases;
  final String label;
  final Color color;

  GlobalCard({
    @required this.icon,
    @required this.cases,
    @required this.label,
    @required this.color,
  });

  @override
  _GlobalCardState createState() => _GlobalCardState();
}

class _GlobalCardState extends State<GlobalCard> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    if (_animation.isCompleted) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: GestureDetector(
        onTap: () {},
        child: Container(
          decoration: kDecoration,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Image.asset(widget.icon, fit: BoxFit.cover, height: 70),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Text(
                  NumberFormat.compact().format(widget.cases).toString(),
                  style: TextStyle(
                    fontSize: 19,
                    color: widget.color,
                    letterSpacing: 1,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Text(
                  widget.label,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[400],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
