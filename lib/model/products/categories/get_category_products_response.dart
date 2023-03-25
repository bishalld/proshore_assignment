// To parse this JSON data, do
//
//     final getCategoryProducts = getCategoryProductsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetCategoryProducts getCategoryProductsFromJson(String str) =>
    GetCategoryProducts.fromJson(json.decode(str));

String getCategoryProductsToJson(GetCategoryProducts data) =>
    json.encode(data.toJson());

class GetCategoryProducts {
  GetCategoryProducts({
    required this.categoryProduct,
  });

  CategoryProduct categoryProduct;

  factory GetCategoryProducts.fromJson(Map<String, dynamic> json) =>
      GetCategoryProducts(
        categoryProduct: CategoryProduct.fromJson(json["categoryProduct"]),
      );

  Map<String, dynamic> toJson() => {
        "categoryProduct": categoryProduct.toJson(),
      };
}

class CategoryProduct {
  CategoryProduct({
    required this.data,
    required this.links,
    required this.meta,
  });

  List<Datum> data;
  Links links;
  Meta meta;

  factory CategoryProduct.fromJson(Map<String, dynamic> json) =>
      CategoryProduct(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        links: Links.fromJson(json["links"]),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "links": links.toJson(),
        "meta": meta.toJson(),
      };
}

class Datum {
  Datum({
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
  int rating;
  int stock;
  String filename;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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

class Links {
  Links({
    required this.first,
    required this.last,
    required this.prev,
    required this.next,
  });

  String first;
  String last;
  dynamic prev;
  String next;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        first: json["first"],
        last: json["last"],
        prev: json["prev"],
        next: json["next"],
      );

  Map<String, dynamic> toJson() => {
        "first": first,
        "last": last,
        "prev": prev,
        "next": next,
      };
}

class Meta {
  Meta({
    required this.currentPage,
    required this.from,
    required this.lastPage,
    required this.links,
    required this.path,
    required this.perPage,
    required this.to,
    required this.total,
  });

  int currentPage;
  int from;
  int lastPage;
  List<Link> links;
  String path;
  int perPage;
  int to;
  int total;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        currentPage: json["current_page"],
        from: json["from"],
        lastPage: json["last_page"],
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        path: json["path"],
        perPage: json["per_page"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "from": from,
        "last_page": lastPage,
        "links": List<dynamic>.from(links.map((x) => x.toJson())),
        "path": path,
        "per_page": perPage,
        "to": to,
        "total": total,
      };
}

class Link {
  Link({
    required this.url,
    required this.label,
    required this.active,
  });

  dynamic url;
  String label;
  bool active;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"] == null ? null : json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url == null ? null : url,
        "label": label,
        "active": active,
      };
}
