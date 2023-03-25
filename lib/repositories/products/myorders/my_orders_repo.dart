import 'dart:developer';

import 'package:meroshopping_flutter/config/constants.dart';
import 'package:http/http.dart' as http;
import 'package:meroshopping_flutter/config/shared_pref.dart';
import 'package:meroshopping_flutter/model/account/order_list_model.dart';

class MyOrdersRepositories {
  Future myOrdersData() async {
    try {
      Uri url = Uri.parse("$ApiBaseUrl/order-history");
      final response = await http.get(
        url,
        headers: {
          "authorization": "Bearer $userToken",
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        // print(response.body);
        return orderListModelFromJson(response.body);
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
