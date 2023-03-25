// // To parse this JSON data, do
// //
// //     final fetchCategories = fetchCategoriesFromJson(jsonString);

// import 'dart:convert';

// FetchCategories fetchCategoriesFromJson(String str) =>
//     FetchCategories.fromJson(json.decode(str));

// String fetchCategoriesToJson(FetchCategories data) =>
//     json.encode(data.toJson());

// class FetchCategories {
//   FetchCategories({
//     required this.data,
//   });

//   List<Datum> data;

//   factory FetchCategories.fromJson(Map<String, dynamic> json) =>
//       FetchCategories(
//         data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//       };
// }

// class Datum {
//   Datum({
//     required this.id,
//     required this.parentId,
//     required this.title,
//     required this.urltitle,
//     required this.image,
//     required this.position,
//     required this.icon,
//     required this.showInMain,
//   });

//   int id;
//   dynamic parentId;
//   dynamic title;
//   dynamic urltitle;
//   dynamic image;
//   int position;
//   dynamic icon;
//   int showInMain;

//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//         id: json["id"],
//         parentId: json["parentId"],
//         title: json["title"],
//         urltitle: json["urltitle"],
//         image: json["image"] == null ? null : json["image"],
//         position: json["position"],
//         icon: json["icon"] == null ? null : json["icon"],
//         showInMain: json["showInMain"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "parentId": parentId,
//         "title": title,
//         "urltitle": urltitle,
//         "image": image,
//         "position": position,
//         "icon": icon,
//         "showInMain": showInMain,
//       };
// }

// To parse this JSON data, do
//
//     final fetchCategories = fetchCategoriesFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

FetchCategories fetchCategoriesFromJson(String str) =>
    FetchCategories.fromJson(json.decode(str));

String fetchCategoriesToJson(FetchCategories data) =>
    json.encode(data.toJson());

class FetchCategories {
  FetchCategories({
    required this.data,
  });

  List<Datum> data;

  factory FetchCategories.fromJson(Map<String, dynamic> json) =>
      FetchCategories(
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

  int id;
  String title;
  String urltitle;
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
