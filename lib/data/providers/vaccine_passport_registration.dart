import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

import '../models/models.dart';

class VaccinePassportRegistration with ChangeNotifier {
  List<VaccinePassport> _passports = [];
  bool _isLoading = false;

  List<VaccinePassport> get passport => _passports;

  bool get isLoading => _isLoading;

  Future<void> getVaccinePassport({
    @required String userId,
    @required String token,
  }) async {
    _isLoading = true;
    _passports.clear();
    notifyListeners();

    final _url = Uri.parse(
        'https://vaccine-passport-67ec6-default-rtdb.firebaseio.com/$userId/vaccine-passport.json?auth=$token');

    try {
      final response = await http.get(_url);
      final responseData = json.decode(response.body) as Map<String, dynamic>;

      if (responseData == null) {
        _isLoading = false;
        notifyListeners();
      } else {
        responseData.forEach((key, value) {
          final _newPassport = VaccinePassport(
            id: key,
            name: value['name'],
            email: value['email'],
            phone: value['phone'],
            gender: value['gender'],
            country: value['country'],
            vaccinationDocumentNumber: value['vaccinationDocumentNumber'],
            date: value['vaccinationDate'],
            profileImage: value['profileImage'],
          );

          _passports.insert(0, _newPassport);

          _isLoading = false;
          notifyListeners();
        });
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> createVaccinePassport({
    @required VaccinePassport passport,
    @required String userId,
    @required String token,
  }) async {
    _isLoading = true;
    notifyListeners();
    final _payload = {
      'name': passport.name,
      'email': passport.email,
      'phone': passport.phone,
      'gender': passport.gender,
      'country': passport.country,
      'vaccinationDocumentNumber': passport.vaccinationDocumentNumber,
      'vaccinationDate': passport.date,
      'profileImage': passport.profileImage,
    };
    final _url = Uri.parse(
        'https://vaccine-passport-67ec6-default-rtdb.firebaseio.com/$userId/vaccine-passport.json?auth=$token');
    try {
      await http.post(_url, body: json.encode(_payload));

      getVaccinePassport(token: token, userId: userId);
      _isLoading = false;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> updateVaccinePassport({
    @required VaccinePassport passport,
    @required String userId,
    @required String token,
  }) async {
    _isLoading = true;
    notifyListeners();
    final _payload = {
      'name': passport.name,
      'email': passport.email,
      'phone': passport.phone,
      'gender': passport.gender,
      'country': passport.country,
      'vaccinationDocumentNumber': passport.vaccinationDocumentNumber,
      'date': passport.date,
      'profileImage': passport.profileImage,
    };
    final _url = Uri.parse(
        'https://vaccine-passport-67ec6-default-rtdb.firebaseio.com/$userId/vaccine-passport/${_passports[0].id}.json?auth=$token');

    try {
      await http.patch(_url, body: json.encode(_payload));
      getVaccinePassport(token: token, userId: userId);
      _isLoading = false;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
