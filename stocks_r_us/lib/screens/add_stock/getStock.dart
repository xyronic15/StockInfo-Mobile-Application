import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:stocks_r_us/ResponseBuilder.dart';
import 'package:stocks_r_us/Stock.dart';
import 'dart:convert';

import 'package:stocks_r_us/UserId.dart';

Future<List<dynamic>> getAllStocks() async {
  final String stocksEndpoint = 'http://10.0.0.115:5000/list_all_stocks';

  final stocksResponse = await http.get(Uri.parse("$stocksEndpoint"));

  List<dynamic> stocksJson = json.decode(stocksResponse.body);

  List<dynamic> stocks = [];

  for (var i = 0; i < stocksJson.length; i++) {
    stocks.add(Stock.fromJson(stocksJson[i]));
  }

  return stocks;
}

Future<ResponseBuilder> addFavourite(String username, int stockId) async {
  final String getIdEndpoint = 'http://10.0.0.115:5000/get_user';
  final idResponse =
      await http.get(Uri.parse("$getIdEndpoint?username=$username"));

  print(jsonDecode(idResponse.body));
  UserId user = UserId.fromJson(jsonDecode(idResponse.body));

  print("ID =============== ${user.id.toString()}");

  final id = user.id;
  print("ID ============> $id");
  print("STOCK ID ==============> $stockId");

  final String addEndpoint = 'http://10.0.0.115:5000/add_fav';
  final response = await http.put(Uri.parse("http://10.0.0.115:5000/add_fav"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, int>{"userID": id, "stockID": stockId}));

  if (response.statusCode == 200) {
    return ResponseBuilder.fromJson(jsonDecode(response.body));
  }

  return ResponseBuilder(message: "Error adding new favorite", statusCode: 400);
}

Future<ResponseBuilder> removeFavourite(String username, int stockId) async {
  final String getIdEndpoint = 'http://10.0.0.115:5000/get_user';
  final idResponse =
      await http.get(Uri.parse("$getIdEndpoint?username=$username"));

  print(jsonDecode(idResponse.body));
  UserId user = UserId.fromJson(jsonDecode(idResponse.body));

  final id = user.id;

  final response =
      await http.delete(Uri.parse("http://10.0.0.115:5000/remove_fav"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, int>{"userID": id, "stockID": stockId}));

  if (response.statusCode == 200) {
    return ResponseBuilder.fromJson(jsonDecode(response.body));
  }

  return ResponseBuilder(message: "Error adding new favorite", statusCode: 400);
}
