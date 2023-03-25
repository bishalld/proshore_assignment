// To parse this JSON data, do
//
//     final registerError = registerErrorFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

RegisterError registerErrorFromJson(String str) =>
    RegisterError.fromJson(json.decode(str));

String registerErrorToJson(RegisterError data) => json.encode(data.toJson());

class RegisterError {
  RegisterError({
    required this.message,
    required this.errors,
    required this.intToken,
  });

  String message;
  int intToken;
  Errors errors;

  factory RegisterError.fromJson(Map<String, dynamic> json) => RegisterError(
        message: json["message"],
        intToken: 1,
        errors: Errors.fromJson(json["errors"]),
      );

  Map<String, dynamic> toJson() => {
        "intToken": intToken,
        "message": message,
        "errors": errors.toJson(),
      };
}

class Errors {
  Errors({
    required this.email,
    required this.contact,
  });

  List<String> email;
  List<String> contact;

  factory Errors.fromJson(Map<String, dynamic> json) => Errors(
        email: List<String>.from(json["email"].map((x) => x)),
        contact: List<String>.from(json["contact"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "email": List<dynamic>.from(email.map((x) => x)),
        "contact": List<dynamic>.from(contact.map((x) => x)),
      };
}
