// // To parse this JSON data, do
// //
// //     final getSubSubCategories = getSubSubCategoriesFromJson(jsonString);

// import 'package:meta/meta.dart';
// import 'dart:convert';

// GetSubSubCategories getSubSubCategoriesFromJson(String str) =>
//     GetSubSubCategories.fromJson(json.decode(str));

// String getSubSubCategoriesToJson(GetSubSubCategories data) =>
//     json.encode(data.toJson());

// class GetSubSubCategories {
//   GetSubSubCategories({
//     required this.data,
//   });

//   List<Datum> data;

//   factory GetSubSubCategories.fromJson(Map<String, dynamic> json) =>
//       GetSubSubCategories(
//         data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//       };
// }

// class Datum {
//   Datum({
//     required this.id,
//     required this.userId,
//     required this.parentId,
//     required this.title,
//     required this.urltitle,
//     required this.description,
//     required this.weight,
//     required this.status,
//     required this.showInFront,
//     required this.frontWeight,
//     required this.pageTitle,
//     required this.pageKeyword,
//     required this.pageDescription,
//     required this.image,
//     required this.position,
//     required this.showInMain,
//     required this.onDate,
//     required this.showInHighlighted,
//     required this.icon,
//     required this.subCategories,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   int id;
//   int userId;
//   int parentId;
//   String title;
//   String urltitle;
//   String description;
//   int weight;
//   int status;
//   int showInFront;
//   int frontWeight;
//   String pageTitle;
//   String pageKeyword;
//   String pageDescription;
//   dynamic image;
//   dynamic position;
//   int showInMain;
//   String onDate;
//   int showInHighlighted;
//   dynamic icon;
//   dynamic subCategories;
//   dynamic createdAt;
//   dynamic updatedAt;

//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//         id: json["id"],
//         userId: json["userId"],
//         parentId: json["parentId"],
//         title: json["title"],
//         urltitle: json["urltitle"],
//         description: json["description"],
//         weight: json["weight"],
//         status: json["status"],
//         showInFront: json["showInFront"],
//         frontWeight: json["frontWeight"],
//         pageTitle: json["pageTitle"],
//         pageKeyword: json["pageKeyword"],
//         pageDescription: json["pageDescription"],
//         image: json["image"],
//         position: json["position"],
//         showInMain: json["showInMain"],
//         onDate: json["onDate"],
//         showInHighlighted: json["showInHighlighted"],
//         icon: json["icon"],
//         subCategories: json["sub_categories"],
//         createdAt: json["created_at"],
//         updatedAt: json["updated_at"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "userId": userId,
//         "parentId": parentId,
//         "title": title,
//         "urltitle": urltitle,
//         "description": description,
//         "weight": weight,
//         "status": status,
//         "showInFront": showInFront,
//         "frontWeight": frontWeight,
//         "pageTitle": pageTitle,
//         "pageKeyword": pageKeyword,
//         "pageDescription": pageDescription,
//         "image": image,
//         "position": position,
//         "showInMain": showInMain,
//         "onDate": onDate,
//         "showInHighlighted": showInHighlighted,
//         "icon": icon,
//         "sub_categories": subCategories,
//         "created_at": createdAt,
//         "updated_at": updatedAt,
//       };
// }

// To parse this JSON data, do
//
//     final getSubSubCategories = getSubSubCategoriesFromJson(jsonString);

// To parse this JSON data, do
//
//     final getSubSubCategories = getSubSubCategoriesFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetSubSubCategories getSubSubCategoriesFromJson(String str) =>
    GetSubSubCategories.fromJson(json.decode(str));

String getSubSubCategoriesToJson(GetSubSubCategories data) =>
    json.encode(data.toJson());

class GetSubSubCategories {
  GetSubSubCategories({
    required this.subsubCategory,
  });

  List<SubsubCategory> subsubCategory;

  factory GetSubSubCategories.fromJson(Map<String, dynamic> json) =>
      GetSubSubCategories(
        subsubCategory: List<SubsubCategory>.from(
            json["subsubCategory"].map((x) => SubsubCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "subsubCategory":
            List<dynamic>.from(subsubCategory.map((x) => x.toJson())),
      };
}

class SubsubCategory {
  SubsubCategory({
    required this.id,
    required this.title,
    required this.urltitle,
    required this.icon,
    required this.image,
  });

  int id;
  String title;
  String urltitle;
  dynamic icon;
  dynamic image;

  factory SubsubCategory.fromJson(Map<String, dynamic> json) => SubsubCategory(
        id: json["id"],
        title: json["title"],
        urltitle: json["urltitle"],
        icon: json["icon"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "urltitle": urltitle,
        "icon": icon,
        "image": image,
      };
}
