import 'dart:developer';

import 'package:meroshopping_flutter/config/constants.dart';
import 'package:http/http.dart' as http;
import 'package:meroshopping_flutter/model/products/brands/brandproductsresponse.dart';
import 'package:meroshopping_flutter/model/products/brands/brands_response.dart';

class BrandRepo {
  Future brands() async {
    try {
      Uri url = Uri.parse("$ApiBaseUrl/brands");
      final response = await http.get(
        url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        return brandsFromJson(response.body);
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future brandProduct(id) async {
    try {
      Uri url = Uri.parse("$ApiBaseUrl/products/brands/$id");
      final response = await http.get(
        url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        return brandProductsFromJson(response.body);
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
