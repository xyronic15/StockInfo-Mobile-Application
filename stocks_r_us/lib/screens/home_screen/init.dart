import 'package:http/http.dart' as http;
import 'package:stocks_r_us/Stock.dart';
import 'dart:convert';

import 'package:stocks_r_us/UserId.dart';

Future<List<dynamic>> getFavourites(String username) async {
  final String getIdEndpoint = 'http://10.0.0.115:5000/get_user';
  final String endpoint = 'http://10.0.0.115:5000/list_fav';

  final idResponse =
      await http.get(Uri.parse("$getIdEndpoint?username=$username"));

  print(jsonDecode(idResponse.body));
  UserId user = UserId.fromJson(jsonDecode(idResponse.body));

  print("ID =============== ${user.id.toString()}");

  final id = user.id.toString();

  final String requestUrl = '$endpoint?id=$id';

  print("REQUEST STRING ====== $requestUrl");

  final response = await http.get(Uri.parse(requestUrl));

  List<dynamic> stocksJson = json.decode(response.body);

  List<dynamic> favStocks = [];

  for (var i = 0; i < stocksJson.length; i++) {
    favStocks.add(Stock.fromJson(stocksJson[i]));
  }
  //print(favStocks[0]);

  return favStocks;
}
