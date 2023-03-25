// To parse this JSON data, do
//
//     final addToCart = addToCartFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AddToCart addToCartFromJson(String str) => AddToCart.fromJson(json.decode(str));

String addToCartToJson(AddToCart data) => json.encode(data.toJson());

class AddToCart {
  AddToCart({
    required this.message,
  });

  String message;

  factory AddToCart.fromJson(Map<String, dynamic> json) => AddToCart(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
