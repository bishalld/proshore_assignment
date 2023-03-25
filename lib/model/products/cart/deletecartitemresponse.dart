// To parse this JSON data, do
//
//     final deleteCartItem = deleteCartItemFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

DeleteCartItem deleteCartItemFromJson(String str) =>
    DeleteCartItem.fromJson(json.decode(str));

String deleteCartItemToJson(DeleteCartItem data) => json.encode(data.toJson());

class DeleteCartItem {
  DeleteCartItem({
    required this.message,
  });

  String message;

  factory DeleteCartItem.fromJson(Map<String, dynamic> json) => DeleteCartItem(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
