import 'dart:convert';

import 'package:meroshopping_flutter/config/constants.dart';
import 'package:http/http.dart' as http;
import 'package:meroshopping_flutter/config/shared_pref.dart';
import 'package:meroshopping_flutter/model/wishlistmodel/wishlistmodel.dart';
import 'dart:developer';

import 'package:meroshopping_flutter/model/wishlistmodel/wishlistresponsemodel.dart';

class WishListRepository {
  Future fetchWishList() async {
    try {
      Uri url = Uri.parse("$ApiBaseUrl/wishlists");
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $userToken',
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        return fetchWishListModelFromJson(response.body);
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  ////
  Future postWish(int wishlist_id) async {
    try {
      var postBody = jsonEncode({
        "wishlist_id": wishlist_id,
      });

      Uri url = Uri.parse("$ApiBaseUrl/addtoWishLists");
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $userToken',
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        body: postBody,
      );

      if (response.statusCode == 200) {
        print(response.body);

        return postWishListModelFromJson(response.body);
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future deleteWish(int wishlistId) async {
    try {
      var postBody = jsonEncode({
        "wishlist_id": wishlistId,
      });

      Uri url = Uri.parse("$ApiBaseUrl/removeWishLists");
      final response = await http.delete(
        url,
        headers: {
          'Authorization': 'Bearer $userToken',
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        body: postBody,
      );

      if (response.statusCode == 200) {
        print(response.body);
        return postWishListModelFromJson(response.body);
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
