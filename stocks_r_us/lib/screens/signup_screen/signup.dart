import 'dart:convert';

import 'package:http/http.dart' as http;

Future<http.Response> userSignup(
    String first, String last, String email, String username, String password) {
  return http.put(Uri.parse("http://10.0.0.115:5000/signup"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "firstname": first,
        "lastname": last,
        "email": email,
        "username": username,
        "password": password
      }));
}
