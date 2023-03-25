// To parse this JSON data, do
//
//     final getSubCategories = getSubCategoriesFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetSubCategories getSubCategoriesFromJson(String str) =>
    GetSubCategories.fromJson(json.decode(str));

String getSubCategoriesToJson(GetSubCategories data) =>
    json.encode(data.toJson());

class GetSubCategories {
  GetSubCategories({
    required this.data,
  });

  List<Datum> data;

  factory GetSubCategories.fromJson(Map<String, dynamic> json) =>
      GetSubCategories(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.title,
    required this.urltitle,
    required this.image,
    required this.icon,
  });

  dynamic id;
  dynamic title;
  dynamic urltitle;
  dynamic image;
  dynamic icon;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"],
        urltitle: json["urltitle"],
        image: json["image"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "urltitle": urltitle,
        "image": image,
        "icon": icon,
      };
}
