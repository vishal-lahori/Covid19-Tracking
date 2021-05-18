import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:url_launcher/url_launcher.dart';

import '../models/models.dart';

class VaccineReports with ChangeNotifier {
  List<VaccineReport> _vaccineReports = [];

  List<VaccineReport> get vaccineReports => _vaccineReports;

  final Api api = Api(
    'https://vaccovid-coronavirus-vaccine-and-treatment-tracker.p.rapidapi.com/api/news/get-vaccine-news/0',
  );

  Future<bool> launchURL({@required String url}) async {
    return await launch(url, statusBarBrightness: Brightness.dark);
  }

  Future getData() async {
    _vaccineReports.clear();
    final response = await http.get(Uri.parse(api.url), headers: api.headers);

    final responseData = json.decode(response.body)['news'];

    responseData.forEach((value) {
      final _vaccineReport = VaccineReport(
        title: value['title'].toString(),
        link: value['link'].toString(),
      );
      _vaccineReports.add(_vaccineReport);
      notifyListeners();
    });
  }
}
