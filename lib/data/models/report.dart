import 'package:flutter/foundation.dart';

class Report {
  final String country;
  final String totalCases;
  final String newCases;
  final String activeCases;
  final String criticalCases;
  final String recovered;
  final String totalDeaths;
  final String image;

  Report({
    this.country,
    @required this.totalCases,
    @required this.newCases,
    @required this.activeCases,
    @required this.criticalCases,
    @required this.recovered,
    @required this.totalDeaths,
    this.image,
  });
}
