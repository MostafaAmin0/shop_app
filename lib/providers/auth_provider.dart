import 'dart:convert';

import 'package:flutter/Foundation.dart';
import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {
  late String _tpken;
  late String _exipiryDate;
  late String _userId;

  Future<void> signUp(String email, String password) async {
    final url = Uri.parse(
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyB0WlFEdRFTAZMjs_64bRhrl5z1Ovj0vDI',
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
    print(json.decode(response.body));
  }
}
