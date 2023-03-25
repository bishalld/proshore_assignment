// To parse this JSON data, do
//
//     final getCartItem = getCartItemFromJson(jsonString);

import 'dart:convert';

GetCartItem getCartItemFromJson(String str) =>
    GetCartItem.fromJson(json.decode(str));

String getCartItemToJson(GetCartItem data) => json.encode(data.toJson());

class GetCartItem {
  GetCartItem({
    required this.cartItems,
  });

  List<CartItem> cartItems;

  factory GetCartItem.fromJson(Map<String, dynamic> json) => GetCartItem(
        cartItems: List<CartItem>.from(
            json["cart_items"].map((x) => CartItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "cart_items": List<dynamic>.from(cartItems.map((x) => x.toJson())),
      };
}

class CartItem {
  CartItem({
    required this.id,
    required this.quantity,
    required this.product,
    required this.color,
    required this.size,
    required this.filename,
    required this.urlname,
    required this.price,
    required this.discount,
    required this.mrp,
  });

  dynamic id;
  dynamic quantity;
  dynamic product;
  dynamic color;
  dynamic size;
  dynamic filename;
  dynamic urlname;
  dynamic price;
  dynamic discount;
  dynamic mrp;

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        id: json["id"],
        quantity: json["quantity"],
        product: json["product"],
        color: json["color"],
        size: json["size"],
        filename: json["filename"],
        urlname: json["urlname"],
        price: json["price"],
        discount: json["discount"],
        mrp: json["mrp"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quantity": quantity,
        "product": product,
        "color": color,
        "size": size,
        "filename": filename,
        "urlname": urlname,
        "price": price,
        "discount": discount,
        "mrp": mrp,
      };
}
