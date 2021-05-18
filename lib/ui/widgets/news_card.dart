import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../data/providers/vaccine_reports.dart';

import '../../ui/constants/constants.dart';

class NewsCard extends StatefulWidget {
  final int index;

  NewsCard({@required this.index});

  @override
  _NewsCardState createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> with TickerProviderStateMixin {
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
    return Consumer<VaccineReports>(builder: (context, reports, _) {
      return ScaleTransition(
        scale: _animation,
        child: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.symmetric(horizontal: 2, vertical: 10),
          decoration: kDecoration,
          child: ListTile(
            leading: Image.asset(
              'assets/icons/newspaper.png',
              fit: BoxFit.cover,
            ),
            title: Text(reports.vaccineReports[widget.index].title),
            onTap: () => reports.launchURL(
              url: reports.vaccineReports[widget.index].link,
            ),
          ),
        ),
      );
    });
  }
}
