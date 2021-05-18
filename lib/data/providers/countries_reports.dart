import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

import '../models/models.dart';

class CountriesReports with ChangeNotifier {
  List<Report> _countriesReports = [];
  bool _isLoading = false;

  List<Report> get countriesReports => _countriesReports;

  bool get isLoading => _isLoading;

  List<Report> searchCountry({@required String keyword}) {
    if (keyword.isEmpty) {
      getData();
    } else {
      _isLoading = true;
      notifyListeners();
      _countriesReports = _countriesReports
          .where((element) => element.country.contains(keyword))
          .toList();
      _isLoading = false;
      notifyListeners();
    }
    notifyListeners();
    return _countriesReports;
  }

  final Api api = Api(
    'https://vaccovid-coronavirus-vaccine-and-treatment-tracker.p.rapidapi.com/api/npm-covid-data/countries',
  );

  Future getData() async {
    _isLoading = true;
    notifyListeners();
    _countriesReports.clear();
    final response = await http.get(Uri.parse(api.url), headers: api.headers);

    final responseData = json.decode(response.body);

    responseData.forEach((value) {
      final Report _report = Report(
        country: value['Country'],
        totalCases: value['TotalCases'].toString(),
        newCases: value['NewCases'].toString(),
        activeCases: value['ActiveCases'].toString(),
        criticalCases: value['Serious_Critical'].toString(),
        recovered: value['TotalRecovered'].toString(),
        totalDeaths: value['TotalDeaths'].toString(),
        image:
            'assets/country_flags/${value['Country'].toString().toLowerCase()}.png',
      );
      _countriesReports.add(_report);
      _isLoading = false;
      notifyListeners();
    });
  }
}
