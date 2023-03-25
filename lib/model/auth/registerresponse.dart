// To parse this JSON data, do
//
//     final register = registerFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Register registerFromJson(String str) => Register.fromJson(json.decode(str));

String registerToJson(Register data) => json.encode(data.toJson());

class Register {
  Register({
    required this.message,
    required this.token,
  });

  String message;
  String token;

  factory Register.fromJson(Map<String, dynamic> json) => Register(
        message: json["message"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "token": token,
      };
}
