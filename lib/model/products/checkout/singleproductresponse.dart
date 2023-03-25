// To parse this JSON data, do
//
//final singleProduct = singleProductFromJson(jsonString);

import 'dart:convert';

SingleProduct singleProductFromJson(String str) =>
    SingleProduct.fromJson(json.decode(str));

String singleProductToJson(SingleProduct data) => json.encode(data.toJson());

class SingleProduct {
  SingleProduct({
    required this.data,
    required this.sizes,
    required this.color,
    required this.category,
    required this.secondparent,
    required this.firstparent,
    required this.relatedproducts,
    required this.bestsellers,
    required this.countReviews,
    required this.perCountReviews,
    required this.totalRating,
    required this.userReviews,
    required this.productImages,
    required this.vendorName,
  });

  Data data;
  List<dynamic> sizes;
  List<dynamic> color;
  Category category;
  Category secondparent;
  Category firstparent;
  List relatedproducts;
  List<dynamic> bestsellers;
  dynamic countReviews;
  List<dynamic> perCountReviews;
  dynamic totalRating;
  List<dynamic> userReviews;
  List<String> productImages;
  dynamic vendorName;

  factory SingleProduct.fromJson(Map<String, dynamic> json) => SingleProduct(
        data: Data.fromJson(json["data"]),
        sizes: List<dynamic>.from(json["sizes"].map((x) => x)),
        color: List<dynamic>.from(json["color"].map((x) => x)),
        category: Category.fromJson(json["category"]),
        secondparent: Category.fromJson(json["secondparent"]),
        firstparent: Category.fromJson(json["firstparent"]),
        relatedproducts: List<Data>.from(
            json["relatedproducts"].map((x) => Data.fromJson(x))),
        bestsellers: List<dynamic>.from(json["bestsellers"].map((x) => x)),
        countReviews: json["count_reviews"],
        perCountReviews:
            List<dynamic>.from(json["per_count_reviews"].map((x) => x)),
        totalRating: json["total_rating"],
        userReviews: List<dynamic>.from(json["user_reviews"].map((x) => x)),
        productImages: List<String>.from(json["product_images"].map((x) => x)),
        vendorName: json["vendor_name"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "sizes": List<dynamic>.from(sizes.map((x) => x)),
        "color": List<dynamic>.from(color.map((x) => x)),
        "category": category.toJson(),
        "secondparent": secondparent.toJson(),
        "firstparent": firstparent.toJson(),
        "relatedproducts":
            List<dynamic>.from(relatedproducts.map((x) => x.toJson())),
        "bestsellers": List<dynamic>.from(bestsellers.map((x) => x)),
        "count_reviews": countReviews,
        "per_count_reviews": List<dynamic>.from(perCountReviews.map((x) => x)),
        "total_rating": totalRating,
        "user_reviews": List<dynamic>.from(userReviews.map((x) => x)),
        "product_images": List<dynamic>.from(productImages.map((x) => x)),
        "vendor_name": vendorName.toJson(),
      };
}

class Category {
  Category({
    required this.id,
    required this.parentId,
    required this.title,
    required this.urltitle,
  });

  dynamic id;
  dynamic parentId;
  dynamic title;
  dynamic urltitle;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        parentId: json["parentId"] == null ? null : json["parentId"],
        title: json["title"],
        urltitle: json["urltitle"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "parentId": parentId == null ? null : parentId,
        "title": title,
        "urltitle": urltitle,
      };
}

class Data {
  Data({
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
    required this.filename,
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
    required this.createdAt,
    required this.updatedAt,
    required this.isFavourite,
    required this.retailer,
  });

  dynamic id;
  dynamic categoryId;
  dynamic retailerId;
  dynamic retailershow;
  dynamic retailercontact;
  dynamic brandId;
  dynamic name;
  dynamic urlname;
  dynamic code;
  dynamic mrp;
  dynamic pricetag;
  dynamic price;
  dynamic discount;
  dynamic unitId;
  dynamic sizeIds;
  dynamic colorIds;
  dynamic warranty;
  dynamic warrantyVal;
  dynamic available;
  dynamic latest;
  dynamic popular;
  dynamic featured;
  dynamic highlighted;
  dynamic features;
  dynamic description;
  dynamic filename;
  dynamic slideshow;
  dynamic weight;
  dynamic minprice;
  dynamic maxprice;
  dynamic minqty;
  dynamic rating;
  dynamic ratingCnt;
  dynamic onDate;
  dynamic updatedDate;
  dynamic stock;
  dynamic pageTitle;
  dynamic pageKeyword;
  dynamic pageDescription;
  dynamic addedBy;
  dynamic updatedBy;
  dynamic status;
  dynamic inFree;
  dynamic allFree;
  dynamic hotDeal;
  dynamic wt;
  dynamic weeklyPopular;
  dynamic subCategories;
  dynamic showInEnquiry;
  dynamic videoUrl;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic isFavourite;
  dynamic retailer;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
        filename: json["filename"],
        slideshow: json["slideshow"],
        weight: json["weight"],
        minprice: json["minprice"],
        maxprice: json["maxprice"],
        minqty: json["minqty"],
        rating: json["rating"],
        ratingCnt: json["ratingCnt"],
        onDate: json["onDate"],
        updatedDate: json["updatedDate"],
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
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        isFavourite: json["isFavourite"],
        retailer: json["retailer"],
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
        "filename": filename,
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
        "created_at": createdAt,
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "isFavourite": isFavourite,
        "retailer": retailer == null ? null : retailer.toJson(),
      };
}

class Retailer {
  Retailer({
    required this.id,
    required this.addedBy,
    required this.contactPerson,
    required this.website,
    required this.percent,
    required this.description,
    required this.pageTitle,
    required this.pageKeyword,
    required this.pageDescription,
    required this.verified,
    required this.createdAt,
    required this.updatedAt,
  });

  dynamic id;
  dynamic addedBy;
  dynamic contactPerson;
  dynamic website;
  dynamic percent;
  dynamic description;
  dynamic pageTitle;
  dynamic pageKeyword;
  dynamic pageDescription;
  dynamic verified;
  dynamic createdAt;
  dynamic updatedAt;

  factory Retailer.fromJson(Map<String, dynamic> json) => Retailer(
        id: json["id"],
        addedBy: json["added_by"],
        contactPerson: json["contact_person"],
        website: json["website"],
        percent: json["percent"],
        description: json["description"],
        pageTitle: json["pageTitle"],
        pageKeyword: json["pageKeyword"],
        pageDescription: json["pageDescription"],
        verified: json["verified"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "added_by": addedBy,
        "contact_person": contactPerson,
        "website": website,
        "percent": percent,
        "description": description,
        "pageTitle": pageTitle,
        "pageKeyword": pageKeyword,
        "pageDescription": pageDescription,
        "verified": verified,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class VendorName {
  VendorName({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerifiedAt,
    required this.password,
    required this.retailerId,
    required this.role,
    required this.address,
    required this.contact,
    required this.photo,
    required this.slug,
    required this.bikeNo,
    required this.branchId,
    required this.rememberToken,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.regionId,
  });

  dynamic id;
  dynamic name;
  dynamic email;
  dynamic emailVerifiedAt;
  dynamic password;
  dynamic retailerId;
  dynamic role;
  dynamic address;
  dynamic contact;
  dynamic photo;
  dynamic slug;
  dynamic bikeNo;
  dynamic branchId;
  dynamic rememberToken;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic status;
  dynamic regionId;

  factory VendorName.fromJson(Map<String, dynamic> json) => VendorName(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        password: json["password"],
        retailerId: json["retailer_id"],
        role: json["role"],
        address: json["address"],
        contact: json["contact"],
        photo: json["photo"],
        slug: json["slug"],
        bikeNo: json["bike_no"],
        branchId: json["branch_id"],
        rememberToken: json["remember_token"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        status: json["status"],
        regionId: json["region_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "password": password,
        "retailer_id": retailerId,
        "role": role,
        "address": address,
        "contact": contact,
        "photo": photo,
        "slug": slug,
        "bike_no": bikeNo,
        "branch_id": branchId,
        "remember_token": rememberToken,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "status": status,
        "region_id": regionId,
      };
}
