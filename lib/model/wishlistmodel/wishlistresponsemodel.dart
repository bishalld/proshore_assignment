import 'dart:convert';

PostWishListModel postWishListModelFromJson(String str) =>
    PostWishListModel.fromJson(json.decode(str));

String postWishListModelToJson(PostWishListModel data) =>
    json.encode(data.toJson());

class PostWishListModel {
  PostWishListModel({
    required this.message,
  });

  dynamic message;

  factory PostWishListModel.fromJson(Map<String, dynamic> json) =>
      PostWishListModel(
        message: json["Message"],
      );

  Map<String, dynamic> toJson() => {
        "Message": message,
      };
}
