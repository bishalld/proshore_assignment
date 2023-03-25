// To parse this JSON data, do
//
//     final checkout = checkoutFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Checkout checkoutFromJson(String str) => Checkout.fromJson(json.decode(str));

String checkoutToJson(Checkout data) => json.encode(data.toJson());

class Checkout {
  Checkout({
    required this.tempId,
    required this.message,
  });

  int tempId;
  String message;

  factory Checkout.fromJson(Map<String, dynamic> json) => Checkout(
        tempId: json["temp_id"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "temp_id": tempId,
        "message": message,
      };
}
