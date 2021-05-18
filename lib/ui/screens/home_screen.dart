import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../widgets/widgets.dart';

import '../screens/screens.dart';

class HomeScreen extends StatelessWidget {
  static const String route = '/home-screen';
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        drawer: NavigationDrawer(),
        appBar: AppBar(
          title: Text(
            'COVID19 TRACKING',
            style: TextStyle(letterSpacing: 1.0),
          ),
          bottom: TabBar(
            physics: BouncingScrollPhysics(),
            indicatorWeight: 4,
            labelPadding: EdgeInsets.symmetric(horizontal: 12),
            tabs: [
              Tab(
                icon: Icon(Icons.public_outlined, size: 30),
                text: 'GLOBAL',
              ),
              Tab(
                icon: Icon(Icons.list_alt_rounded, size: 30),
                text: 'ALL-COUNTRIES',
              ),
              Tab(
                icon: FaIcon(FontAwesomeIcons.syringe, size: 28),
                text: 'UPDATES',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            GlobalScreen(),
            AllCountriesScreen(),
            VaccinesReportsScreen(),
          ],
        ),
      ),
    );
  }
}
