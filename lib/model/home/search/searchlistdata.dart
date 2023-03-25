// // To parse this JSON data, do
// //
// //     final searchListResponse = searchListResponseFromJson(jsonString);

// import 'dart:convert';

// SearchListResponse searchListResponseFromJson(String str) =>
//     SearchListResponse.fromJson(json.decode(str));

// String searchListResponseToJson(SearchListResponse data) =>
//     json.encode(data.toJson());

// class SearchListResponse {
//   SearchListResponse({
//     required this.searchData,
//   });

//   dynamic searchData;

//   factory SearchListResponse.fromJson(Map<String, dynamic> json) =>
//       SearchListResponse(
//         searchData: SearchData.fromJson(json["searchData"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "searchData": searchData.toJson(),
//       };
// }

// class SearchData {
//   SearchData({
//     required this.currentPage,
//     required this.data,
//     required this.firstPageUrl,
//     required this.from,
//     required this.lastPage,
//     required this.lastPageUrl,
//     required this.links,
//     required this.nextPageUrl,
//     required this.path,
//     required this.perPage,
//     required this.prevPageUrl,
//     required this.to,
//     required this.total,
//   });

//   dynamic currentPage;
//   List<Datum> data;
//   dynamic firstPageUrl;
//   dynamic from;
//   dynamic lastPage;
//   dynamic lastPageUrl;
//   List<Link> links;
//   dynamic nextPageUrl;
//   dynamic path;
//   dynamic perPage;
//   dynamic prevPageUrl;
//   dynamic to;
//   dynamic total;

//   factory SearchData.fromJson(Map<String, dynamic> json) => SearchData(
//         currentPage: json["current_page"],
//         data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//         firstPageUrl: json["first_page_url"],
//         from: json["from"],
//         lastPage: json["last_page"],
//         lastPageUrl: json["last_page_url"],
//         links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
//         nextPageUrl: json["next_page_url"],
//         path: json["path"],
//         perPage: json["per_page"],
//         prevPageUrl: json["prev_page_url"],
//         to: json["to"],
//         total: json["total"],
//       );

//   Map<String, dynamic> toJson() => {
//         "current_page": currentPage,
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//         "first_page_url": firstPageUrl,
//         "from": from,
//         "last_page": lastPage,
//         "last_page_url": lastPageUrl,
//         "links": List<dynamic>.from(links.map((x) => x.toJson())),
//         "next_page_url": nextPageUrl,
//         "path": path,
//         "per_page": perPage,
//         "prev_page_url": prevPageUrl,
//         "to": to,
//         "total": total,
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
//   });

//   dynamic id;
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
//   dynamic createdAt;

//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//         id: json["id"],
//         categoryId: json["categoryId"],
//         retailerId: json["retailerId"] == null ? null : json["retailerId"],
//         retailershow: json["retailershow"],
//         retailercontact: json["retailercontact"],
//         brandId: json["brandId"] == null ? null : json["brandId"],
//         name: json["name"],
//         urlname: json["urlname"],
//         code: json["code"] == null ? null : json["code"],
//         mrp: json["mrp"],
//         pricetag: json["pricetag"],
//         price: json["price"],
//         discount: json["discount"],
//         unitId: json["unit_id"],
//         sizeIds: json["sizeIds"] == null ? null : json["sizeIds"],
//         colorIds: json["colorIds"] == null ? null : json["colorIds"],
//         warranty: json["warranty"],
//         warrantyVal: json["warranty_val"],
//         available: json["available"],
//         latest: json["latest"] == null ? null : json["latest"],
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
//         subCategories:
//             json["sub_categories"] == null ? null : json["sub_categories"],
//         showInEnquiry:
//             json["show_in_enquiry"] == null ? null : json["show_in_enquiry"],
//         videoUrl: json["video_url"],
//         createdAt: json["created_at"],
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
//       };
// }

// class Link {
//   Link({
//     required this.url,
//     required this.label,
//     required this.active,
//   });

//   dynamic url;
//   dynamic label;
//   bool active;

//   factory Link.fromJson(Map<String, dynamic> json) => Link(
//         url: json["url"] == null ? null : json["url"],
//         label: json["label"],
//         active: json["active"],
//       );

//   Map<String, dynamic> toJson() => {
//         "url": url,
//         "label": label,
//         "active": active,
//       };
// }

// To parse this JSON data, do
//
//     final searchListResponse = searchListResponseFromJson(jsonString);

import 'dart:convert';

SearchListResponse searchListResponseFromJson(String str) =>
    SearchListResponse.fromJson(json.decode(str));

String searchListResponseToJson(SearchListResponse data) =>
    json.encode(data.toJson());

class SearchListResponse {
  SearchListResponse({
    required this.data,
  });

  List<Datum> data;

  factory SearchListResponse.fromJson(Map<String, dynamic> json) =>
      SearchListResponse(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.categoryId,
    required this.retailerId,
    required this.retailershow,
    required this.retailercontact,
    required this.brandId,
    required this.name,
    required this.urlname,
    required this.code,
    required this.mrp,
    required this.pricetag,
    required this.price,
    required this.discount,
    required this.unitId,
    required this.sizeIds,
    required this.colorIds,
    required this.warranty,
    required this.warrantyVal,
    required this.available,
    required this.latest,
    required this.popular,
    required this.featured,
    required this.highlighted,
    required this.features,
    required this.description,
    required this.slideshow,
    required this.weight,
    required this.minprice,
    required this.maxprice,
    required this.minqty,
    required this.rating,
    required this.ratingCnt,
    required this.onDate,
    required this.updatedDate,
    required this.stock,
    required this.pageTitle,
    required this.pageKeyword,
    required this.pageDescription,
    required this.addedBy,
    required this.updatedBy,
    required this.status,
    required this.inFree,
    required this.allFree,
    required this.hotDeal,
    required this.wt,
    required this.weeklyPopular,
    required this.subCategories,
    required this.showInEnquiry,
    required this.videoUrl,
    required this.filename,
  });

  int id;
  int categoryId;
  int retailerId;
  int retailershow;
  int retailercontact;
  int brandId;
  String name;
  String urlname;
  String code;
  int mrp;
  String pricetag;
  int price;
  int discount;
  int unitId;
  String sizeIds;
  String colorIds;
  String warranty;
  String warrantyVal;
  dynamic available;
  dynamic latest;
  String popular;
  String featured;
  dynamic highlighted;
  String features;
  String description;
  String slideshow;
  String weight;
  int minprice;
  int maxprice;
  int minqty;
  int rating;
  int ratingCnt;
  DateTime onDate;
  DateTime updatedDate;
  int stock;
  String pageTitle;
  String pageKeyword;
  String pageDescription;
  int addedBy;
  int updatedBy;
  int status;
  int inFree;
  int allFree;
  int hotDeal;
  String wt;
  int weeklyPopular;
  dynamic subCategories;
  dynamic showInEnquiry;
  dynamic videoUrl;
  String filename;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        categoryId: json["categoryId"],
        retailerId: json["retailerId"],
        retailershow: json["retailershow"],
        retailercontact: json["retailercontact"],
        brandId: json["brandId"],
        name: json["name"],
        urlname: json["urlname"],
        code: json["code"],
        mrp: json["mrp"],
        pricetag: json["pricetag"],
        price: json["price"],
        discount: json["discount"],
        unitId: json["unit_id"],
        sizeIds: json["sizeIds"],
        colorIds: json["colorIds"],
        warranty: json["warranty"],
        warrantyVal: json["warranty_val"],
        available: json["available"],
        latest: json["latest"],
        popular: json["popular"],
        featured: json["featured"],
        highlighted: json["highlighted"],
        features: json["features"],
        description: json["description"],
        slideshow: json["slideshow"],
        weight: json["weight"],
        minprice: json["minprice"],
        maxprice: json["maxprice"],
        minqty: json["minqty"],
        rating: json["rating"],
        ratingCnt: json["ratingCnt"],
        onDate: DateTime.parse(json["onDate"]),
        updatedDate: DateTime.parse(json["updatedDate"]),
        stock: json["stock"],
        pageTitle: json["pageTitle"],
        pageKeyword: json["pageKeyword"],
        pageDescription: json["pageDescription"],
        addedBy: json["addedBy"],
        updatedBy: json["updatedBy"],
        status: json["status"],
        inFree: json["in_free"],
        allFree: json["all_free"],
        hotDeal: json["hot_deal"],
        wt: json["wt"],
        weeklyPopular: json["weekly_popular"],
        subCategories: json["sub_categories"],
        showInEnquiry: json["show_in_enquiry"],
        videoUrl: json["video_url"],
        filename: json["filename"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "categoryId": categoryId,
        "retailerId": retailerId,
        "retailershow": retailershow,
        "retailercontact": retailercontact,
        "brandId": brandId,
        "name": name,
        "urlname": urlname,
        "code": code,
        "mrp": mrp,
        "pricetag": pricetag,
        "price": price,
        "discount": discount,
        "unit_id": unitId,
        "sizeIds": sizeIds,
        "colorIds": colorIds,
        "warranty": warranty,
        "warranty_val": warrantyVal,
        "available": available,
        "latest": latest,
        "popular": popular,
        "featured": featured,
        "highlighted": highlighted,
        "features": features,
        "description": description,
        "slideshow": slideshow,
        "weight": weight,
        "minprice": minprice,
        "maxprice": maxprice,
        "minqty": minqty,
        "rating": rating,
        "ratingCnt": ratingCnt,
        "onDate":
            "${onDate.year.toString().padLeft(4, '0')}-${onDate.month.toString().padLeft(2, '0')}-${onDate.day.toString().padLeft(2, '0')}",
        "updatedDate": updatedDate.toIso8601String(),
        "stock": stock,
        "pageTitle": pageTitle,
        "pageKeyword": pageKeyword,
        "pageDescription": pageDescription,
        "addedBy": addedBy,
        "updatedBy": updatedBy,
        "status": status,
        "in_free": inFree,
        "all_free": allFree,
        "hot_deal": hotDeal,
        "wt": wt,
        "weekly_popular": weeklyPopular,
        "sub_categories": subCategories,
        "show_in_enquiry": showInEnquiry,
        "video_url": videoUrl,
        "filename": filename,
      };
}

// enum Available { NO, YES }

// final availableValues = EnumValues({
//     "no": Available.NO,
//     "yes": Available.YES
// });

// class EnumValues<T> {
//     Map<String, T> map;
//     Map<T, String> reverseMap;

//     EnumValues(this.map);

//     Map<T, String> get reverse {
//         if (reverseMap == null) {
//             reverseMap = map.map((k, v) => new MapEntry(v, k));
//         }
//         return reverseMap;
//     }
// }

