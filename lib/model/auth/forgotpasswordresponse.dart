// To parse this JSON data, do
//
//     final forgotPassword = forgotPasswordFromJson(jsonString);

import 'dart:convert';

ForgotPassword forgotPasswordFromJson(String str) =>
    ForgotPassword.fromJson(json.decode(str));

String forgotPasswordToJson(ForgotPassword data) => json.encode(data.toJson());

class ForgotPassword {
  ForgotPassword({
    required this.message,
  });

  String message;

  factory ForgotPassword.fromJson(Map<String, dynamic> json) => ForgotPassword(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
