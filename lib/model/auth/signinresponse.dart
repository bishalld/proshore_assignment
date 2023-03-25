// To parse this JSON data, do
//
//     final signIn = signInFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SignIn signInFromJson(String str) => SignIn.fromJson(json.decode(str));

String signInToJson(SignIn data) => json.encode(data.toJson());

class SignIn {
  SignIn({
    required this.message,
    required this.token,
  });

  dynamic message;
  dynamic token;

  factory SignIn.fromJson(Map<String, dynamic> json) => SignIn(
        message: json["message"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "token": token,
      };
}
