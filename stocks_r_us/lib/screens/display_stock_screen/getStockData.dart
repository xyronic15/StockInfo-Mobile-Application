import 'package:http/http.dart' as http;
import 'package:stocks_r_us/ResponseBuilder.dart';
import 'dart:convert';
import 'package:stocks_r_us/stockData.dart';

Future<StockData> getStockData(String ticker) async {
  final response = await http
      .get(Uri.parse("http://10.0.0.115:5000/get_data?ticker=$ticker"));

  return StockData.fromJson(jsonDecode(response.body));
}
