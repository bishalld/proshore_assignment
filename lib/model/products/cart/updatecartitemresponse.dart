// To parse this JSON data, do
//
//     final updateCartItem = updateCartItemFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UpdateCartItem updateCartItemFromJson(String str) =>
    UpdateCartItem.fromJson(json.decode(str));

String updateCartItemToJson(UpdateCartItem data) => json.encode(data.toJson());

class UpdateCartItem {
  UpdateCartItem({
    required this.message,
  });

  String message;

  factory UpdateCartItem.fromJson(Map<String, dynamic> json) => UpdateCartItem(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
