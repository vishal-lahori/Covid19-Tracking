import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../data/providers/global_reports.dart';

import '../widgets/widgets.dart';

class GlobalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalReports>(
      builder: (context, reports, _) {
        return GridView(
          padding: const EdgeInsets.all(20),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 0.9,
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
          ),
          physics: BouncingScrollPhysics(),
          children: [
            GlobalCard(
              icon: 'assets/icons/total.png',
              cases: double.parse(reports.globalReport.totalCases),
              label: 'Total',
              color: Colors.lime,
            ),
            GlobalCard(
              icon: 'assets/icons/new.png',
              cases: double.parse(reports.globalReport.newCases),
              label: 'New',
              color: Colors.pink[400],
            ),
            GlobalCard(
              icon: 'assets/icons/active.png',
              cases: double.parse(reports.globalReport.activeCases),
              label: 'Active',
              color: Colors.lightBlue,
            ),
            GlobalCard(
              icon: 'assets/icons/critical.png',
              cases: double.parse(reports.globalReport.criticalCases),
              label: 'Critical',
              color: Colors.amber,
            ),
            GlobalCard(
              icon: 'assets/icons/recovered.png',
              cases: double.parse(reports.globalReport.recovered),
              label: 'Recovered',
              color: Colors.lightGreen,
            ),
            GlobalCard(
              icon: 'assets/icons/deaths.png',
              cases: double.parse(reports.globalReport.totalDeaths),
              label: 'Deaths',
              color: Colors.red,
            ),
          ],
        );
      },
    );
  }
}
