import 'package:flutter/rendering.dart';

class Stock {
  final String name;
  final String ticker;
  final int id;

  Stock({required this.name, required this.ticker, required this.id});

  factory Stock.fromJson(Map<dynamic, dynamic> json) {
    return Stock(name: json["name"], ticker: json["ticker"], id: json["id"]);
  }

  @override
  String toString() {
    return "name: ${name}, ticker: ${ticker}, id: ${id}";
  }
}
