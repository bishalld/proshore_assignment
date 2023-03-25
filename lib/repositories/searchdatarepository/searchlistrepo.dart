import 'dart:developer';

import 'package:meroshopping_flutter/config/constants.dart';
import 'package:http/http.dart' as http;
import 'package:meroshopping_flutter/model/home/search/searchlistdata.dart';

class SearchRepo {
  Future searchList(productName) async {
    try {
      Uri url = Uri.parse("$ApiBaseUrl/search/?productName=$productName");
      final response = await http.get(
        url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        // print(response.body);
        return searchListResponseFromJson(response.body);
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
