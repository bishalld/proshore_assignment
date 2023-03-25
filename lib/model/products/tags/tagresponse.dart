// To parse this JSON data, do
//
//     final tags = tagsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Tags tagsFromJson(String str) => Tags.fromJson(json.decode(str));

String tagsToJson(Tags data) => json.encode(data.toJson());

class Tags {
  Tags({
    required this.data,
  });

  List<Datum> data;

  factory Tags.fromJson(Map<String, dynamic> json) => Tags(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.name,
    required this.urlname,
    required this.image,
  });

  int id;
  String name;
  String urlname;
  String image;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        urlname: json["urlname"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "urlname": urlname,
        "image": image,
      };
}
