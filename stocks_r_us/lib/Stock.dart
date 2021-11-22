import 'package:flutter/rendering.dart';

class Stock {
  final String name;
  final String ticker;

  Stock({required this.name, required this.ticker});

  factory Stock.fromJson(Map<dynamic, dynamic> json) {
    return Stock(name: json["name"], ticker: json["ticker"]);
  }

  @override
  String toString() {
    return "name: ${name}, ticker: ${ticker}";
  }
}
