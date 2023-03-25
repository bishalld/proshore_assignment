// To parse this JSON data, do
//
//     final tagProducts = tagProductsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

TagProducts tagProductsFromJson(String str) =>
    TagProducts.fromJson(json.decode(str));

String tagProductsToJson(TagProducts data) => json.encode(data.toJson());

class TagProducts {
  TagProducts({
    required this.tagsProducts,
  });

  List<TagsProduct> tagsProducts;

  factory TagProducts.fromJson(Map<String, dynamic> json) => TagProducts(
        tagsProducts: List<TagsProduct>.from(
            json["tagsProducts"].map((x) => TagsProduct.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "tagsProducts": List<dynamic>.from(tagsProducts.map((x) => x.toJson())),
      };
}

class TagsProduct {
  TagsProduct({
    required this.id,
    // required this.categoryId,
    // required this.retailerId,
    // required this.retailershow,
    // required this.retailercontact,
    // required this.brandId,
    required this.name,
    required this.urlname,
    // required this.code,
    // required this.mrp,
    // required this.pricetag,
    required this.price,
    // required this.discount,
    // required this.unitId,
    // required this.sizeIds,
    // required this.colorIds,
    // required this.warranty,
    // required this.warrantyVal,
    // required this.available,
    // required this.latest,
    // required this.popular,
    // required this.featured,
    // required this.highlighted,
    // required this.features,
    // required this.description,
    // required this.slideshow,
    // required this.weight,
    // required this.minprice,
    // required this.maxprice,
    // required this.minqty,
    required this.rating,
    // required this.ratingCnt,
    // required this.onDate,
    // required this.updatedDate,
    // required this.stock,
    // required this.pageTitle,
    // required this.pageKeyword,
    // required this.pageDescription,
    // required this.addedBy,
    // required this.updatedBy,
    // required this.status,
    // required this.inFree,
    // required this.allFree,
    // required this.hotDeal,
    // required this.wt,
    // required this.weeklyPopular,
    // required this.subCategories,
    // required this.showInEnquiry,
    // required this.videoUrl,
    required this.filename,
  });

  int id;
  // int categoryId;
  // dynamic retailerId;
  // dynamic retailershow;
  // dynamic retailercontact;
  // dynamic brandId;
  String name;
  String urlname;
  // dynamic code;
  // dynamic mrp;
  // dynamic pricetag;
  int price;
  // dynamic discount;
  // dynamic unitId;
  // dynamic sizeIds;
  // String colorIds;
  // String warranty;
  // dynamic warrantyVal;
  // String available;
  // String latest;
  // String popular;
  // String featured;
  // String highlighted;
  // String features;
  // String description;
  // dynamic slideshow;
  // String weight;
  // dynamic minprice;
  // dynamic maxprice;
  // int minqty;
  dynamic rating;
  // dynamic ratingCnt;
  // dynamic onDate;
  // dynamic updatedDate;
  // int stock;
  // String pageTitle;
  // String pageKeyword;
  // String pageDescription;
  // int addedBy;
  // dynamic updatedBy;
  // int status;
  // int inFree;
  // int allFree;
  // int hotDeal;
  // dynamic wt;
  // int weeklyPopular;
  // String subCategories;
  // int showInEnquiry;
  // dynamic videoUrl;
  String filename;

  factory TagsProduct.fromJson(Map<String, dynamic> json) => TagsProduct(
        id: json["id"],
        // categoryId: json["categoryId"],
        // retailerId: json["retailerId"],
        // retailershow: json["retailershow"],
        // retailercontact: json["retailercontact"],
        // brandId: json["brandId"],
        name: json["name"],
        urlname: json["urlname"],
        // code: json["code"],
        // mrp: json["mrp"],
        // pricetag: json["pricetag"],
        price: json["price"],
        // discount: json["discount"],
        // unitId: json["unit_id"],
        // sizeIds: json["sizeIds"],
        // colorIds: json["colorIds"],
        // warranty: json["warranty"],
        // warrantyVal: json["warranty_val"],
        // available: json["available"],
        // latest: json["latest"] == null ? null : json["latest"],
        // popular: json["popular"],
        // featured: json["featured"],
        // highlighted: json["highlighted"],
        // features: json["features"],
        // description: json["description"],
        // slideshow: json["slideshow"],
        // weight: json["weight"],
        // minprice: json["minprice"],
        // maxprice: json["maxprice"],
        // minqty: json["minqty"],
        rating: json["rating"],
        // ratingCnt: json["ratingCnt"],
        // onDate: json["onDate"],
        // updatedDate: json["updatedDate"],
        // stock: json["stock"],
        // pageTitle: json["pageTitle"],
        // pageKeyword: json["pageKeyword"],
        // pageDescription: json["pageDescription"],
        // addedBy: json["addedBy"],
        // updatedBy: json["updatedBy"],
        // status: json["status"],
        // inFree: json["in_free"],
        // allFree: json["all_free"],
        // hotDeal: json["hot_deal"],
        // wt: json["wt"],
        // weeklyPopular: json["weekly_popular"],
        // subCategories: json["sub_categories"],
        // showInEnquiry: json["show_in_enquiry"],
        // videoUrl: json["video_url"],
        filename: json["filename"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        // "categoryId": categoryId,
        // "retailerId": retailerId,
        // "retailershow": retailershow,
        // "retailercontact": retailercontact,
        // "brandId": brandId,
        "name": name,
        "urlname": urlname,
        // "code": code,
        // "mrp": mrp,
        // "pricetag": pricetag,
        "price": price,
        // "discount": discount,
        // "unit_id": unitId,
        // "sizeIds": sizeIds,
        // "colorIds": colorIds,
        // "warranty": warranty,
        // "warranty_val": warrantyVal,
        // "available": available,
        // "latest": latest == null ? null : latest,
        // "popular": popular,
        // "featured": featured,
        // "highlighted": highlighted,
        // "features": features,
        // "description": description,
        // "slideshow": slideshow,
        // "weight": weight,
        // "minprice": minprice,
        // "maxprice": maxprice,
        // "minqty": minqty,
        "rating": rating,
        // "ratingCnt": ratingCnt,
        // "onDate": onDate,
        // "updatedDate": updatedDate,
        // "stock": stock,
        // "pageTitle": pageTitle,
        // "pageKeyword": pageKeyword,
        // "pageDescription": pageDescription,
        // "addedBy": addedBy,
        // "updatedBy": updatedBy,
        // "status": status,
        // "in_free": inFree,
        // "all_free": allFree,
        // "hot_deal": hotDeal,
        // "wt": wt,
        // "weekly_popular": weeklyPopular,
        // "sub_categories": subCategories,
        // "show_in_enquiry": showInEnquiry,
        // "video_url": videoUrl,
        "filename": filename,
      };
}
