// To parse this JSON data, do
//
//     final wishListAddedResponse = wishListAddedResponseFromJson(jsonString);

import 'dart:convert';

WishListAddedResponse wishListAddedResponseFromJson(String str) =>
    WishListAddedResponse.fromJson(json.decode(str));

String wishListAddedResponseToJson(WishListAddedResponse data) =>
    json.encode(data.toJson());

class WishListAddedResponse {
  WishListAddedResponse({
    required this.message,
  });

  String message;

  factory WishListAddedResponse.fromJson(Map<String, dynamic> json) =>
      WishListAddedResponse(
        message: json["Message"],
      );

  Map<String, dynamic> toJson() => {
        "Message": message,
      };
}
