import 'package:http/http.dart' as http;
import 'package:stocks_r_us/ResponseBuilder.dart';
import 'dart:convert';

Future<ResponseBuilder> userSignup(String first, String last, String email,
    String username, String password) async {
//   return http.put(Uri.parse("http://10.0.0.115:5000/signup"),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(<String, String>{
//         "firstname": first,
//         "lastname": last,
//         "email": email,
//         "username": username,
//         "password": password
//       }));

  final response = await http.put(Uri.parse("http://10.0.0.115:5000/signup"),
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

  final status = response.statusCode;
  final message = response.body;
  print("STATUS CODE ========= ${status}");
  print("MESSAGE ==== ${message}");

  if (response.statusCode == 200) {
    return ResponseBuilder.fromJson(jsonDecode(response.body));
  }

  return ResponseBuilder(message: "error", statusCode: 400);
}
