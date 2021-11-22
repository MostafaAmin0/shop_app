import 'dart:convert';

import 'package:flutter/Foundation.dart';
import 'package:http/http.dart' as http;

import '../model/http_exception.dart';

class AuthProvider with ChangeNotifier {
  String? _token;
  DateTime? _exipiryDate;
  String? _userId;

  bool get isAuth {
    return _token != null;
  }

  String? get token {
    if (_token != null &&
        _exipiryDate != null &&
        _exipiryDate!.isAfter(DateTime.now())) {
      return _token;
    }
    return null;
  }

  String get userId => _userId ?? '';

  Future<void> signUp(String email, String password) async {
    ///await or return should work probably
    await _authenticate(email, password, 'signUp');
  }

  Future<void> logIn(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }

  Future<void> _authenticate(
      String email, String password, String specialSegment) async {
    final url = Uri.parse(
      'https://identitytoolkit.googleapis.com/v1/accounts:$specialSegment?key=AIzaSyB0WlFEdRFTAZMjs_64bRhrl5z1Ovj0vDI',
    );

    final response = await http.post(
      url,
      body: json.encode(
        {
          'email': email,
          'password': password,
          'returnSecureToken': true,
        },
      ),
    );
    final responseData = json.decode(response.body);
    if (responseData['error'] != null) {
      throw HttpException(responseData['error']['message']);
    }
    _token = responseData['idToken'];
    _userId = responseData['localId'];
    _exipiryDate = DateTime.now().add(
      Duration(seconds: int.parse(responseData['expiresIn'])),
    );
    notifyListeners();
  }
}
