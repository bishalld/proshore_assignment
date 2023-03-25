// // To parse this JSON data, do
// //
// //     final getSubCategoryProducts = getSubCategoryProductsFromJson(jsonString);

// import 'dart:convert';

// GetSubCategoryProducts getSubCategoryProductsFromJson(String str) =>
//     GetSubCategoryProducts.fromJson(json.decode(str));

// String getSubCategoryProductsToJson(GetSubCategoryProducts data) =>
//     json.encode(data.toJson());

// class GetSubCategoryProducts {
//   GetSubCategoryProducts({
//     required this.data,
//   });

//   List<Datum> data;

//   factory GetSubCategoryProducts.fromJson(Map<String, dynamic> json) =>
//       GetSubCategoryProducts(
//         data: List<Datum>.from(
//             json["categoryProduct"].map((x) => Datum.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "categoryProduct": List<dynamic>.from(data.map((x) => x.toJson())),
//       };
// }

// class Datum {
//   Datum({
//     required this.id,
//     required this.categoryId,
//     required this.retailerId,
//     required this.retailershow,
//     required this.retailercontact,
//     required this.brandId,
//     required this.name,
//     required this.urlname,
//     required this.code,
//     required this.mrp,
//     required this.pricetag,
//     required this.price,
//     required this.discount,
//     required this.unitId,
//     required this.sizeIds,
//     required this.colorIds,
//     required this.warranty,
//     required this.warrantyVal,
//     required this.available,
//     required this.latest,
//     required this.popular,
//     required this.featured,
//     required this.highlighted,
//     required this.features,
//     required this.description,
//     required this.filename,
//     required this.slideshow,
//     required this.weight,
//     required this.minprice,
//     required this.maxprice,
//     required this.minqty,
//     required this.rating,
//     required this.ratingCnt,
//     required this.onDate,
//     required this.updatedDate,
//     required this.stock,
//     required this.pageTitle,
//     required this.pageKeyword,
//     required this.pageDescription,
//     required this.addedBy,
//     required this.updatedBy,
//     required this.status,
//     required this.inFree,
//     required this.allFree,
//     required this.hotDeal,
//     required this.wt,
//     required this.weeklyPopular,
//     required this.subCategories,
//     required this.showInEnquiry,
//     required this.videoUrl,
//   });

//   int id;
//   dynamic categoryId;
//   dynamic retailerId;
//   dynamic retailershow;
//   dynamic retailercontact;
//   dynamic brandId;
//   dynamic name;
//   dynamic urlname;
//   dynamic code;
//   dynamic mrp;
//   dynamic pricetag;
//   dynamic price;
//   dynamic discount;
//   dynamic unitId;
//   dynamic sizeIds;
//   dynamic colorIds;
//   dynamic warranty;
//   dynamic warrantyVal;
//   dynamic available;
//   dynamic latest;
//   dynamic popular;
//   dynamic featured;
//   dynamic highlighted;
//   dynamic features;
//   dynamic description;
//   dynamic filename;
//   dynamic slideshow;
//   dynamic weight;
//   dynamic minprice;
//   dynamic maxprice;
//   dynamic minqty;
//   dynamic rating;
//   dynamic ratingCnt;
//   DateTime onDate;
//   DateTime updatedDate;
//   dynamic stock;
//   dynamic pageTitle;
//   dynamic pageKeyword;
//   dynamic pageDescription;
//   dynamic addedBy;
//   dynamic updatedBy;
//   dynamic status;
//   dynamic inFree;
//   dynamic allFree;
//   dynamic hotDeal;
//   dynamic wt;
//   dynamic weeklyPopular;
//   dynamic subCategories;
//   dynamic showInEnquiry;
//   dynamic videoUrl;

//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//         id: json["id"],
//         categoryId: json["categoryId"],
//         retailerId: json["retailerId"],
//         retailershow: json["retailershow"],
//         retailercontact: json["retailercontact"],
//         brandId: json["brandId"],
//         name: json["name"],
//         urlname: json["urlname"],
//         code: json["code"],
//         mrp: json["mrp"],
//         pricetag: json["pricetag"],
//         price: json["price"],
//         discount: json["discount"],
//         unitId: json["unit_id"],
//         sizeIds: json["sizeIds"],
//         colorIds: json["colorIds"],
//         warranty: json["warranty"],
//         warrantyVal: json["warranty_val"],
//         available: json["available"],
//         latest: json["latest"],
//         popular: json["popular"],
//         featured: json["featured"],
//         highlighted: json["highlighted"],
//         features: json["features"],
//         description: json["description"],
//         filename: json["filename"],
//         slideshow: json["slideshow"],
//         weight: json["weight"],
//         minprice: json["minprice"],
//         maxprice: json["maxprice"],
//         minqty: json["minqty"],
//         rating: json["rating"],
//         ratingCnt: json["ratingCnt"],
//         onDate: DateTime.parse(json["onDate"]),
//         updatedDate: DateTime.parse(json["updatedDate"]),
//         stock: json["stock"],
//         pageTitle: json["pageTitle"],
//         pageKeyword: json["pageKeyword"],
//         pageDescription: json["pageDescription"],
//         addedBy: json["addedBy"],
//         updatedBy: json["updatedBy"],
//         status: json["status"],
//         inFree: json["in_free"],
//         allFree: json["all_free"],
//         hotDeal: json["hot_deal"],
//         wt: json["wt"],
//         weeklyPopular: json["weekly_popular"],
//         subCategories: json["sub_categories"],
//         showInEnquiry: json["show_in_enquiry"],
//         videoUrl: json["video_url"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "categoryId": categoryId,
//         "retailerId": retailerId,
//         "retailershow": retailershow,
//         "retailercontact": retailercontact,
//         "brandId": brandId,
//         "name": name,
//         "urlname": urlname,
//         "code": code,
//         "mrp": mrp,
//         "pricetag": pricetag,
//         "price": price,
//         "discount": discount,
//         "unit_id": unitId,
//         "sizeIds": sizeIds,
//         "colorIds": colorIds,
//         "warranty": warranty,
//         "warranty_val": warrantyVal,
//         "available": available,
//         "latest": latest,
//         "popular": popular,
//         "featured": featured,
//         "highlighted": highlighted,
//         "features": features,
//         "description": description,
//         "filename": filename,
//         "slideshow": slideshow,
//         "weight": weight,
//         "minprice": minprice,
//         "maxprice": maxprice,
//         "minqty": minqty,
//         "rating": rating,
//         "ratingCnt": ratingCnt,
//         "onDate":
//             "${onDate.year.toString().padLeft(4, '0')}-${onDate.month.toString().padLeft(2, '0')}-${onDate.day.toString().padLeft(2, '0')}",
//         "updatedDate": updatedDate.toIso8601String(),
//         "stock": stock,
//         "pageTitle": pageTitle,
//         "pageKeyword": pageKeyword,
//         "pageDescription": pageDescription,
//         "addedBy": addedBy,
//         "updatedBy": updatedBy,
//         "status": status,
//         "in_free": inFree,
//         "all_free": allFree,
//         "hot_deal": hotDeal,
//         "wt": wt,
//         "weekly_popular": weeklyPopular,
//         "sub_categories": subCategories,
//         "show_in_enquiry": showInEnquiry,
//         "video_url": videoUrl,
//       };
// }

// To parse this JSON data, do
//
//     final getSubCategoryProducts = getSubCategoryProductsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetSubCategoryProducts getSubCategoryProductsFromJson(String str) =>
    GetSubCategoryProducts.fromJson(json.decode(str));

String getSubCategoryProductsToJson(GetSubCategoryProducts data) =>
    json.encode(data.toJson());

class GetSubCategoryProducts {
  GetSubCategoryProducts({
    required this.subCategoryProduct,
  });

  List<SubCategoryProduct> subCategoryProduct;

  factory GetSubCategoryProducts.fromJson(Map<String, dynamic> json) =>
      GetSubCategoryProducts(
        subCategoryProduct: List<SubCategoryProduct>.from(
            json["subCategoryProduct"]
                .map((x) => SubCategoryProduct.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "subCategoryProduct":
            List<dynamic>.from(subCategoryProduct.map((x) => x.toJson())),
      };
}

class SubCategoryProduct {
  SubCategoryProduct({
    required this.id,
    required this.name,
    required this.urlname,
    required this.price,
    required this.description,
    required this.rating,
    required this.stock,
    required this.filename,
  });

  int id;
  dynamic name;
  dynamic urlname;
  dynamic price;
  dynamic description;
  dynamic rating;
  dynamic stock;
  dynamic filename;

  factory SubCategoryProduct.fromJson(Map<String, dynamic> json) =>
      SubCategoryProduct(
        id: json["id"],
        name: json["name"],
        urlname: json["urlname"],
        price: json["price"],
        description: json["description"],
        rating: json["rating"],
        stock: json["stock"],
        filename: json["filename"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "urlname": urlname,
        "price": price,
        "description": description,
        "rating": rating,
        "stock": stock,
        "filename": filename,
      };
}
