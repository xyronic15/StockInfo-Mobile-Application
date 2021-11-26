import 'package:flutter/rendering.dart';

class StockData {
  final double currentPrice;
  final double dayHigh;
  final double dayLow;
  final double dividendYield;
  final double openPrice;
  final String logoLink;
  final String sector;

  StockData(
      {required this.currentPrice,
      required this.dayHigh,
      required this.dayLow,
      required this.dividendYield,
      required this.openPrice,
      required this.logoLink,
      required this.sector});

  factory StockData.fromJson(Map<dynamic, dynamic> json) {
    return StockData(
        currentPrice: json["currentPrice"],
        dayHigh: json["dayHigh"],
        dayLow: json["dayLow"],
        dividendYield: json["dividendYield"],
        openPrice: json["open"],
        logoLink: json["logo"],
        sector: json["sector"]);
  }
}
