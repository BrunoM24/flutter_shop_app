import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:shop_app/models/http_exception.dart';

const apiToken = "AIzaSyDkNcrS0eqi7paCkRTU9RIswTiG8-jRzSQ";

class Auth with ChangeNotifier {
  late String _token;
  DateTime? _expireDate;
  late String _userId;

  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (_expireDate != null && _expireDate!.isAfter(DateTime.now())) {
      return _token;
    }

    return null;
  }

  Future<Response> signup(String email, String password) async {
    Uri url = Uri.parse(
      "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$apiToken",
    );

    return _sendHTTPRequest(url, email, password);
  }

  Future<Response?> login(String email, String password) async {
    Uri url = Uri.parse(
      "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$apiToken",
    );

    return _sendHTTPRequest(url, email, password);
  }

  Future<Response> _sendHTTPRequest(
    Uri url,
    String email,
    String password,
  ) async {
    final response = await post(
      url,
      body: jsonEncode(
        {
          'email': email,
          'password': password,
          'returnSecureToken': true,
        },
      ),
    );

    final data = jsonDecode(response.body);

    if (data['error'] != null) {
      throw HttpException(data['error']['message']);
    }

    _token = data['idToken'];
    _userId = data['localId'];
    _expireDate = DateTime.now().add(
      Duration(seconds: int.parse(data['expiresIn'])),
    );

    notifyListeners();

    return response;
  }
}
