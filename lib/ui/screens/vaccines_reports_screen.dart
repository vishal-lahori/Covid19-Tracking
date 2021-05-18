import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../data/providers/vaccine_reports.dart';

import '../widgets/widgets.dart';

class VaccinesReportsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<VaccineReports>(
        builder: (context, reports, _) {
          return ListView.builder(
            padding: EdgeInsets.all(10),
            physics: BouncingScrollPhysics(),
            itemCount: reports.vaccineReports.length,
            itemBuilder: (context, index) {
              return NewsCard(index: index);
            },
          );
        },
      ),
    );
  }
}
