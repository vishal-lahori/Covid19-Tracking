import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

import '../models/models.dart';

class GlobalReports with ChangeNotifier {
  Report _globalReport;

  Report get globalReport => _globalReport;

  final Api api = Api(
    'https://vaccovid-coronavirus-vaccine-and-treatment-tracker.p.rapidapi.com/api/npm-covid-data/world',
  );

  Future getData() async {
    final response = await http.get(Uri.parse(api.url), headers: api.headers);

    final responseData = json.decode(response.body);

    responseData.forEach((value) {
      _globalReport = Report(
        totalCases: value['TotalCases'].toString(),
        newCases: value['NewCases'].toString(),
        activeCases: value['ActiveCases'].toString(),
        criticalCases: value['Serious_Critical'].toString(),
        recovered: value['TotalRecovered'].toString(),
        totalDeaths: value['TotalDeaths'].toString(),
      );
      notifyListeners();
    });
  }
}
