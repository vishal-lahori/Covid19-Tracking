import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

class Authentication with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  String get userId => _userId;
  bool get isAuthenticated => token != null;

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  final String _apiKey = 'AIzaSyBlVMA9ihMbtqadUx6tqAZQ1GjApSY_jMw';

  Future<void> authenticate({
    @required String email,
    @required String password,
    @required int action,
  }) async {
    final Uri signUpUrl = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_apiKey');

    final Uri signInUrl = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_apiKey');

    final Map<String, dynamic> payload = {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };

    final response = await http.post(
      action == 1 ? signInUrl : signUpUrl,
      body: json.encode(payload),
    );

    final responseData = json.decode(response.body);

    // if (responseData['error'] != null) {
    //   throw Exception(responseData['error']['message']);
    // }

    _token = responseData['idToken'];
    _userId = responseData['localId'];
    _expiryDate = DateTime.now().add(
      Duration(
        seconds: int.parse(responseData['expiresIn']),
      ),
    );
    print('TOKEN ------------------------ $_token');
    notifyListeners();
  }
}
