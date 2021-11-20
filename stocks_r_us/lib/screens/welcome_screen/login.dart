import 'dart:convert';

import 'package:http/http.dart' as http;

Future<http.Response> userLogin(String username, String password) {
  return http.post(Uri.parse("http://10.0.0.115:5000/login"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, String>{"username": username, "password": password}));
}
