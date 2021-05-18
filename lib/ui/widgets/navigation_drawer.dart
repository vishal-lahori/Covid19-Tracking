import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../data/providers/providers.dart';

import '../screens/screens.dart';

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          height: double.infinity,
          width: 250,
          color: Colors.black26,
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                ListTile(
                  selectedTileColor: Colors.amber,
                  onTap: () =>
                      Navigator.pushNamed(context, HowItSpreadScreen.route),
                  title: Text(
                    'How It\'s Spread',
                    style: TextStyle(fontSize: 16),
                  ),
                  leading: Icon(
                    Icons.coronavirus_outlined,
                    size: 28,
                    color: Colors.deepOrange,
                  ),
                ),
                Divider(indent: 70, thickness: 2),
                ListTile(
                  onTap: () => Navigator.pushNamed(
                      context, SafetyPrecautionsScreen.route),
                  title: Text(
                    'Safety Precautions',
                    style: TextStyle(fontSize: 16),
                  ),
                  leading: Icon(
                    Icons.local_hospital_outlined,
                    size: 28,
                    color: Colors.blue,
                  ),
                ),
                Divider(indent: 70, thickness: 2),
                ListTile(
                  onTap: () {
                    return Navigator.pushNamed(
                      context,
                      // auth.isAuthenticated
                      // CreateProfileScreen.route
                      VaccinePassportAuthScreen.route,
                      // VaccinePassportScreen.route,
                    );
                  },
                  title: Text(
                    'Vaccine Passport',
                    style: TextStyle(fontSize: 16),
                  ),
                  leading: Icon(
                    Icons.badge,
                    size: 28,
                    color: Colors.amber,
                  ),
                ),
                // Divider(indent: 70, thickness: 2),
                // ListTile(
                //   onTap: () => Navigator.pushNamed(context, AboutScreen.route),
                //   title: Text(
                //     'About',
                //     style: TextStyle(fontSize: 16),
                //   ),
                //   leading: Icon(
                //     Icons.contact_support_outlined,
                //     size: 28,
                //     color: Colors.cyan,
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
