// To parse this JSON data, do
//
//     final brands = brandsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Brands brandsFromJson(String str) => Brands.fromJson(json.decode(str));

String brandsToJson(Brands data) => json.encode(data.toJson());

class Brands {
  Brands({
    required this.data,
  });

  List<Datum> data;

  factory Brands.fromJson(Map<String, dynamic> json) => Brands(
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
    required this.logo,
    required this.front,
  });

  int id;
  dynamic name;
  dynamic urlname;
  dynamic logo;
  int front;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        urlname: json["urlname"],
        logo: json["logo"] == null ? null : json["logo"],
        front: json["front"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "urlname": urlname,
        "logo": logo == null ? null : logo,
        "front": front,
      };
}
