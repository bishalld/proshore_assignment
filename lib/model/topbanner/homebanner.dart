// To parse this JSON data, do
//
//     final bannerModel = bannerModelFromJson(jsonString);

import 'dart:convert';

BannerModel bannerModelFromJson(String str) =>
    BannerModel.fromJson(json.decode(str));

String bannerModelToJson(BannerModel data) => json.encode(data.toJson());

class BannerModel {
  BannerModel({
    required this.data,
  });

  List<Datum> data;

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.link,
    required this.status,
    required this.position,
    required this.image,
  });

  String link;
  int status;
  String position;
  String image;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        link: json["link"],
        status: json["status"],
        position: json["position"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "link": link,
        "status": status,
        "position": position,
        "image": image,
      };
}
