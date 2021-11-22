import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:stocks_r_us/ResponseBuilder.dart';

Future<ResponseBuilder> userLogin(String username, String password) async {
  final response = await http.post(Uri.parse("http://10.0.0.115:5000/login"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, String>{"username": username, "password": password}));

  if (response.statusCode == 200) {
    return ResponseBuilder.fromJson(jsonDecode(response.body));
  }

  return ResponseBuilder(message: "Login Error", statusCode: 400);
}
