// // To parse this JSON data, do
// //
// //     final getSubSubCategoryProducts = getSubSubCategoryProductsFromJson(jsonString);

// import 'dart:convert';

// GetSubSubCategoryProducts getSubSubCategoryProductsFromJson(String str) =>
//     GetSubSubCategoryProducts.fromJson(json.decode(str));

// String getSubSubCategoryProductsToJson(GetSubSubCategoryProducts data) =>
//     json.encode(data.toJson());

// class GetSubSubCategoryProducts {
//   GetSubSubCategoryProducts({
//     required this.data,
//   });

//   List<Datum> data;

//   factory GetSubSubCategoryProducts.fromJson(Map<String, dynamic> json) =>
//       GetSubSubCategoryProducts(
//         data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
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
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   int id;
//   int categoryId;
//   int retailerId;
//   int retailershow;
//   int retailercontact;
//   int brandId;
//   String name;
//   String urlname;
//   String code;
//   int mrp;
//   String pricetag;
//   int price;
//   int discount;
//   int unitId;
//   String sizeIds;
//   String colorIds;
//   String warranty;
//   String warrantyVal;
//   String available;
//   dynamic latest;
//   String popular;
//   String featured;
//   String highlighted;
//   String features;
//   String description;
//   String filename;
//   String slideshow;
//   String weight;
//   int minprice;
//   int maxprice;
//   int minqty;
//   int rating;
//   int ratingCnt;
//   DateTime onDate;
//   DateTime updatedDate;
//   int stock;
//   String pageTitle;
//   String pageKeyword;
//   String pageDescription;
//   int addedBy;
//   int updatedBy;
//   int status;
//   int inFree;
//   int allFree;
//   int hotDeal;
//   String wt;
//   int weeklyPopular;
//   dynamic subCategories;
//   dynamic showInEnquiry;
//   dynamic videoUrl;
//   dynamic createdAt;
//   dynamic updatedAt;

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
//         createdAt: json["created_at"],
//         updatedAt: json["updated_at"],
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
//         "created_at": createdAt,
//         "updated_at": updatedAt,
//       };
// }

// To parse this JSON data, do
//
//     final getSubSubCategoryProducts = getSubSubCategoryProductsFromJson(jsonString);
// To parse this JSON data, do
//
//     final getSubSubCategoryProducts = getSubSubCategoryProductsFromJson(jsonString);

import 'dart:convert';

GetSubSubCategoryProducts getSubSubCategoryProductsFromJson(String str) =>
    GetSubSubCategoryProducts.fromJson(json.decode(str));

String getSubSubCategoryProductsToJson(GetSubSubCategoryProducts data) =>
    json.encode(data.toJson());

class GetSubSubCategoryProducts {
  GetSubSubCategoryProducts({
    required this.subsubCategoryProduct,
  });

  List<SubsubCategoryProduct> subsubCategoryProduct;

  factory GetSubSubCategoryProducts.fromJson(Map<String, dynamic> json) =>
      GetSubSubCategoryProducts(
        subsubCategoryProduct: List<SubsubCategoryProduct>.from(
            json["subsubCategoryProduct"]
                .map((x) => SubsubCategoryProduct.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "subsubCategoryProduct":
            List<dynamic>.from(subsubCategoryProduct.map((x) => x.toJson())),
      };
}

class SubsubCategoryProduct {
  SubsubCategoryProduct({
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
  String name;
  String urlname;
  int price;
  String description;
  dynamic rating;
  dynamic stock;
  String filename;

  factory SubsubCategoryProduct.fromJson(Map<String, dynamic> json) =>
      SubsubCategoryProduct(
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
