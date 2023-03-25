// To parse this JSON data, do
//
//     final orderListModel = orderListModelFromJson(jsonString);

import 'dart:convert';

OrderListModel orderListModelFromJson(String str) =>
    OrderListModel.fromJson(json.decode(str));

String orderListModelToJson(OrderListModel data) => json.encode(data.toJson());

class OrderListModel {
  OrderListModel({
    required this.message,
    required this.orderhistory,
  });

  dynamic message;
  List orderhistory;

  factory OrderListModel.fromJson(Map<String, dynamic> json) => OrderListModel(
        message: json["message"],
        orderhistory: List<Orderhistory>.from(
            json["orderhistory"].map((x) => Orderhistory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "orderhistory": List<dynamic>.from(orderhistory.map((x) => x.toJson())),
      };
}

class Orderhistory {
  Orderhistory({
    required this.id,
    required this.clientId,
    required this.createdBy,
    required this.updatedBy,
    required this.orderedFrom,
    required this.email,
    required this.name,
    required this.address,
    required this.city,
    required this.contact,
    required this.state,
    required this.addContact,
    required this.totalAmount,
    required this.comments,
    required this.discount,
    required this.amount,
    required this.deliveryCharge,
    required this.orderStatus,
    required this.paymentType,
    required this.area,
    required this.shippingTime,
    required this.clientType,
    required this.assignedDelivery,
    required this.ncmRefId,
    required this.orderNote,
    required this.branchId,
    required this.prepaidAmount,
    required this.paymentOptions,
    required this.confirmedAt,
    required this.dispatchedAt,
    required this.deliveredAt,
    required this.returnedAt,
    required this.cancelledAt,
    required this.trashedBy,
    required this.trashedAt,
    required this.revertBy,
    required this.createdAt,
    required this.updatedAt,
    required this.product,
  });

  int id;
  int clientId;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic orderedFrom;
  dynamic email;
  dynamic name;
  dynamic address;
  dynamic city;
  dynamic contact;
  dynamic state;
  dynamic addContact;
  int totalAmount;
  dynamic comments;
  int discount;
  int amount;
  int deliveryCharge;
  dynamic orderStatus;
  dynamic paymentType;
  int area;
  dynamic shippingTime;
  dynamic clientType;
  dynamic assignedDelivery;
  dynamic ncmRefId;
  dynamic orderNote;
  dynamic branchId;
  dynamic prepaidAmount;
  dynamic paymentOptions;
  dynamic confirmedAt;
  dynamic dispatchedAt;
  dynamic deliveredAt;
  dynamic returnedAt;
  dynamic cancelledAt;
  dynamic trashedBy;
  dynamic trashedAt;
  dynamic revertBy;
  dynamic createdAt;
  dynamic updatedAt;
  List<Product> product;

  factory Orderhistory.fromJson(Map<String, dynamic> json) => Orderhistory(
        id: json["id"],
        clientId: json["client_id"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        orderedFrom: json["ordered_from"],
        email: json["email"],
        name: json["name"],
        address: json["address"],
        city: json["city"],
        contact: json["contact"],
        state: json["state"],
        addContact: json["add_contact"],
        totalAmount: json["total_amount"],
        comments: json["comments"],
        discount: json["discount"],
        amount: json["amount"],
        deliveryCharge: json["delivery_charge"],
        orderStatus: json["order_status"],
        paymentType: json["payment_type"],
        area: json["area"],
        shippingTime: json["shipping_time"],
        clientType: json["client_type"],
        assignedDelivery: json["assigned_delivery"],
        ncmRefId: json["ncm_ref_id"],
        orderNote: json["order_note"],
        branchId: json["branch_id"],
        prepaidAmount: json["prepaid_amount"],
        paymentOptions: json["payment_options"],
        confirmedAt: json["confirmed_at"],
        dispatchedAt: json["dispatched_at"],
        deliveredAt: json["delivered_at"],
        returnedAt: json["returned_at"],
        cancelledAt: json["cancelled_at"],
        trashedBy: json["trashed_by"],
        trashedAt: json["trashed_at"],
        revertBy: json["revert_by"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        product:
            List<Product>.from(json["product"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "client_id": clientId,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "ordered_from": orderedFrom,
        "email": email,
        "name": name,
        "address": address,
        "city": city,
        "contact": contact,
        "state": state,
        "add_contact": addContact,
        "total_amount": totalAmount,
        "comments": comments,
        "discount": discount,
        "amount": amount,
        "delivery_charge": deliveryCharge,
        "order_status": orderStatus,
        "payment_type": paymentType,
        "area": area,
        "shipping_time": shippingTime,
        "client_type": clientType,
        "assigned_delivery": assignedDelivery,
        "ncm_ref_id": ncmRefId,
        "order_note": orderNote,
        "branch_id": branchId,
        "prepaid_amount": prepaidAmount,
        "payment_options": paymentOptions,
        "confirmed_at": confirmedAt,
        "dispatched_at": dispatchedAt,
        "delivered_at": deliveredAt,
        "returned_at": returnedAt,
        "cancelled_at": cancelledAt,
        "trashed_by": trashedBy,
        "trashed_at": trashedAt,
        "revert_by": revertBy,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "product": List<dynamic>.from(product.map((x) => x.toJson())),
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
    required this.pivot,
  });

  int id;
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
  dynamic pivot;

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
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        pivot: Pivot.fromJson(json["pivot"]),
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
        "created_at": createdAt,
        "updated_at": updatedAt,
        "pivot": pivot.toJson(),
      };
}

class Pivot {
  Pivot({
    required this.orderId,
    required this.productId,
  });

  int orderId;
  int productId;

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        orderId: json["order_id"],
        productId: json["product_id"],
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "product_id": productId,
      };
}
