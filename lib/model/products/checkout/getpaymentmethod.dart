import 'dart:convert';

GetpaymentMethod getpaymentMethodFromJson(String str) =>
    GetpaymentMethod.fromJson(json.decode(str));

String getpaymentMethodToJson(GetpaymentMethod data) =>
    json.encode(data.toJson());

class GetpaymentMethod {
  GetpaymentMethod({
    required this.name,
    required this.address,
    required this.email,
    required this.contact,
    required this.city,
    required this.state,
    required this.comments,
    required this.cart,
    required this.amount,
    required this.discount,
    required this.deliveryCharge,
    required this.totalAmount,
    required this.area,
    required this.shippingTime,
  });

  dynamic name;
  dynamic address;
  dynamic email;
  dynamic contact;
  dynamic city;
  dynamic state;
  dynamic comments;
  List<Cart> cart;
  dynamic amount;
  dynamic discount;
  dynamic deliveryCharge;
  dynamic totalAmount;
  dynamic area;
  dynamic shippingTime;

  factory GetpaymentMethod.fromJson(Map<String, dynamic> json) =>
      GetpaymentMethod(
        name: json["name"],
        address: json["address"],
        email: json["email"],
        contact: json["contact"],
        city: json["city"],
        state: json["state"],
        comments: json["comments"],
        cart: List<Cart>.from(json["cart"].map((x) => Cart.fromJson(x))),
        amount: json["amount"],
        discount: json["discount"],
        deliveryCharge: json["delivery_charge"],
        totalAmount: json["total_amount"],
        area: json["area"],
        shippingTime: json["shipping_time"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "address": address,
        "email": email,
        "contact": contact,
        "city": city,
        "state": state,
        "comments": comments,
        "cart": List<dynamic>.from(cart.map((x) => x.toJson())),
        "amount": amount,
        "discount": discount,
        "delivery_charge": deliveryCharge,
        "total_amount": totalAmount,
        "area": area,
        "shipping_time": shippingTime,
      };
}

class Cart {
  Cart({
    required this.id,
    required this.productId,
    required this.clientId,
    required this.quantity,
    required this.colorId,
    required this.sizeId,
    required this.product,
  });

  dynamic id;
  dynamic productId;
  String clientId;
  dynamic quantity;
  dynamic colorId;
  dynamic sizeId;
  dynamic product;

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
      id: json["id"],
      productId: json["product_id"],
      clientId: json["client_id"],
      quantity: json["quantity"],
      colorId: json["color_id"] == null ? null : json["color_id"],
      sizeId: json["size_id"] == null ? null : json["size_id"],
      product: json["product"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "client_id": clientId,
        "quantity": quantity,
        "color_id": colorId,
        "size_id": sizeId,
        "product": product
      };
}

class Product {
  Product({
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
  });

  int id;
  int categoryId;
  dynamic retailerId;
  dynamic retailershow;
  dynamic retailercontact;
  dynamic brandId;
  String name;
  String urlname;
  dynamic code;
  dynamic mrp;
  dynamic pricetag;
  int price;
  dynamic discount;
  dynamic unitId;
  dynamic sizeIds;
  String colorIds;
  String warranty;
  dynamic warrantyVal;
  String available;
  String latest;
  String popular;
  String featured;
  String highlighted;
  String features;
  String description;
  String filename;
  dynamic slideshow;
  String weight;
  dynamic minprice;
  dynamic maxprice;
  int minqty;
  dynamic rating;
  dynamic ratingCnt;
  dynamic onDate;
  dynamic updatedDate;
  int stock;
  String pageTitle;
  String pageKeyword;
  String pageDescription;
  int addedBy;
  dynamic updatedBy;
  int status;
  int inFree;
  int allFree;
  int hotDeal;
  dynamic wt;
  int weeklyPopular;
  String subCategories;
  int showInEnquiry;
  dynamic videoUrl;
  dynamic createdAt;
  dynamic updatedAt;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
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
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
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
        "onDate": onDate,
        "updatedDate": updatedDate,
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
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
