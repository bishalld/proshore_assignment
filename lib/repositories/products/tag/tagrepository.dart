import 'dart:developer';

import 'package:meroshopping_flutter/config/constants.dart';
import 'package:http/http.dart' as http;
import 'package:meroshopping_flutter/model/products/tags/tagproductresponse.dart';
import 'package:meroshopping_flutter/model/products/tags/tagresponse.dart';

class TagRepo {
  Future tags() async {
    try {
      Uri url = Uri.parse("$ApiBaseUrl/tags");
      final response = await http.get(
        url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        return tagsFromJson(response.body);
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future tagProduct(id) async {
    try {
      Uri url = Uri.parse("$ApiBaseUrl/products/tags/$id");
      final response = await http.get(
        url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        return tagProductsFromJson(response.body);
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
