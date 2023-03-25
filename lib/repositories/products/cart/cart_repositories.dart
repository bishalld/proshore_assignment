import 'package:meroshopping_flutter/config/shared_pref.dart';
import 'package:meroshopping_flutter/model/auth/signinresponse.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:meroshopping_flutter/config/constants.dart';
import 'package:http/http.dart' as http;
import 'package:meroshopping_flutter/model/products/cart/addtocartresponse.dart';
import 'package:meroshopping_flutter/model/products/cart/deletecartitemresponse.dart';
import 'package:meroshopping_flutter/model/products/cart/getcartitemresponse.dart';
import 'package:meroshopping_flutter/model/products/cart/updatecartitemresponse.dart';

class CartRepository {
  ///Add to cart function
  Future addToCart(product_id, quantity, size_id, color_id) async {
    try {
      var postBody = jsonEncode({
        "product_id": product_id,
        "quantity": quantity,
        "size_id": size_id,
        "color_id": color_id,
      });
      Uri url = Uri.parse("$ApiBaseUrl/add-to-cart");
      final response = await http.post(
        url,
        headers: {
          "authorization": "Bearer $userToken",
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        body: postBody,
      );

      if (response.statusCode == 201) {
        return addToCartFromJson(response.body);
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  ///get cart items function
  Future getcartItem() async {
    try {
      Uri url = Uri.parse("$ApiBaseUrl/view-cart");
      final response = await http.get(
        url,
        headers: {
          "authorization": "Bearer $userToken",
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        return getCartItemFromJson(response.body);
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  ///update cart item function
  Future updateCartItem(cart_id, quantity) async {
    try {
      var postBody = jsonEncode({
        "cart_id": cart_id,
        "quantity": quantity,
      });
      Uri url = Uri.parse("$ApiBaseUrl/update-cart");
      final response = await http.put(
        url,
        headers: {
          "authorization": "Bearer $userToken",
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        body: postBody,
      );

      if (response.statusCode == 201) {
        return updateCartItemFromJson(response.body);
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  ///delete cart item function
  Future deleteCartItem(cart_id) async {
    try {
      var postBody = jsonEncode({
        "cart_id": cart_id,
      });
      Uri url = Uri.parse("$ApiBaseUrl/delete-cart");
      final response = await http.delete(
        url,
        headers: {
          "authorization": "Bearer $userToken",
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        body: postBody,
      );
      print(response.body);
      if (response.statusCode == 201) {
        return deleteCartItemFromJson(response.body);
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
