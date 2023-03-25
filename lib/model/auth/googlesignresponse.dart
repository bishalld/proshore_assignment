// To parse this JSON data, do
//
//     final googleSignIn = googleSignInFromJson(jsonString);

import 'dart:convert';

GoogleSignIn googleSignInFromJson(String str) =>
    GoogleSignIn.fromJson(json.decode(str));

String googleSignInToJson(GoogleSignIn data) => json.encode(data.toJson());

class GoogleSignIn {
  GoogleSignIn({
    required this.status,
    required this.success,
    required this.message,
    required this.token,
    required this.filename,
  });

  dynamic status;
  bool success;
  dynamic message;
  dynamic token;
  dynamic filename;

  factory GoogleSignIn.fromJson(Map<String, dynamic> json) => GoogleSignIn(
        status: json["status"],
        success: json["success"],
        message: json["message"],
        token: json["token"],
        filename: json["filename"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "success": success,
        "message": message,
        "token": token,
        "filename": filename,
      };
}
