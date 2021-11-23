import 'package:flutter/rendering.dart';

class ResponseBuilder {
  final String message;
  final int statusCode;

  ResponseBuilder({required this.message, required this.statusCode});

  factory ResponseBuilder.fromJson(Map<dynamic, dynamic> json) {
    return ResponseBuilder(
        message: json["message"], statusCode: json["status"]);
  }
}
