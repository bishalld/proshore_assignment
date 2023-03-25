// To parse this JSON data, do
//
//     final topSellingProducts = topSellingProductsFromJson(jsonString);

import 'dart:convert';

TopSellingProducts topSellingProductsFromJson(String str) =>
    TopSellingProducts.fromJson(json.decode(str));

String topSellingProductsToJson(TopSellingProducts data) =>
    json.encode(data.toJson());

class TopSellingProducts {
  TopSellingProducts({
    required this.data,
  });

  List<Datum> data;

  factory TopSellingProducts.fromJson(Map<String, dynamic> json) =>
      TopSellingProducts(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
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
    required this.filename,
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
  });

  dynamic id;
  // dynamic categoryId;
  // dynamic retailerId;
  // dynamic retailershow;
  // dynamic retailercontact;
  // dynamic brandId;
  dynamic name;
  dynamic urlname;
  // dynamic code;
  // dynamic mrp;
  // dynamic pricetag;
  dynamic price;
  // dynamic discount;
  // dynamic unitId;
  // dynamic sizeIds;
  // dynamic colorIds;
  // dynamic warranty;
  // dynamic warrantyVal;
  // dynamic available;
  // dynamic latest;
  // dynamic popular;
  // dynamic featured;
  // dynamic highlighted;
  // dynamic features;
  // dynamic description;
  dynamic filename;
  // dynamic slideshow;
  // dynamic weight;
  // dynamic minprice;
  // dynamic maxprice;
  // dynamic minqty;
  dynamic rating;
  // dynamic ratingCnt;
  // dynamic onDate;
  // dynamic updatedDate;
  // dynamic stock;
  // dynamic pageTitle;
  // dynamic pageKeyword;
  // dynamic pageDescription;
  // dynamic addedBy;
  // dynamic updatedBy;
  // dynamic status;
  // dynamic inFree;
  // dynamic allFree;
  // dynamic hotDeal;
  // dynamic wt;
  // dynamic weeklyPopular;
  // dynamic subCategories;
  // dynamic showInEnquiry;
  // dynamic videoUrl;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        // categoryId: json["categoryId"],
        // retailerId: json["retailerId"] == null ? null : json["retailerId"],
        // retailershow:
        //     json["retailershow"] == null ? null : json["retailershow"],
        // retailercontact:
        //     json["retailercontact"] == null ? null : json["retailercontact"],
        // brandId: json["brandId"] == null ? null : json["brandId"],
        name: json["name"],
        urlname: json["urlname"],
        // code: json["code"] == null ? null : json["code"],
        // mrp: json["mrp"] == null ? null : json["mrp"],
        // pricetag: json["pricetag"] == null ? null : json["pricetag"],
        price: json["price"],
        // discount: json["discount"] == null ? null : json["discount"],
        // unitId: json["unit_id"] == null ? null : json["unit_id"],
        // sizeIds: json["sizeIds"] == null ? null : json["sizeIds"],
        // colorIds: json["colorIds"] == null ? null : json["colorIds"],
        // warranty: json["warranty"],
        // warrantyVal: json["warranty_val"] == null ? null : json["warranty_val"],
        // available: json["available"],
        // latest: json["latest"] == null ? null : json["latest"],
        // popular: json["popular"],
        // featured: json["featured"],
        // highlighted: json["highlighted"],
        // features: json["features"],
        // description: json["description"],
        filename: json["filename"],
        // slideshow: json["slideshow"] == null ? null : json["slideshow"],
        // weight: json["weight"],
        // minprice: json["minprice"] == null ? null : json["minprice"],
        // maxprice: json["maxprice"] == null ? null : json["maxprice"],
        // minqty: json["minqty"],
        rating: json["rating"] == null ? null : json["rating"],
        // ratingCnt: json["ratingCnt"] == null ? null : json["ratingCnt"],
        // onDate: json["onDate"],
        // updatedDate: json["updatedDate"],
        // stock: json["stock"],
        // pageTitle: json["pageTitle"],
        // pageKeyword: json["pageKeyword"],
        // pageDescription: json["pageDescription"],
        // addedBy: json["addedBy"],
        // updatedBy: json["updatedBy"] == null ? null : json["updatedBy"],
        // status: json["status"],
        // inFree: json["in_free"],
        // allFree: json["all_free"],
        // hotDeal: json["hot_deal"],
        // wt: json["wt"] == null ? null : json["wt"],
        // weeklyPopular: json["weekly_popular"],
        // subCategories:
        //     json["sub_categories"] == null ? null : json["sub_categories"],
        // showInEnquiry:
        //     json["show_in_enquiry"] == null ? null : json["show_in_enquiry"],
        // videoUrl: json["video_url"] == null ? null : json["video_url"],
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
        // "latest": latest,
        // "popular": popular,
        // "featured": featured,
        // "highlighted": highlighted,
        // "features": features,
        // "description": description,
        "filename": filename,
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
      };
}
