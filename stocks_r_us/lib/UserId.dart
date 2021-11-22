import 'package:flutter/rendering.dart';

class UserId {
  final int id;

  UserId({required this.id});

  factory UserId.fromJson(Map<dynamic, dynamic> json) {
    return UserId(id: json["id"]);
  }
}
