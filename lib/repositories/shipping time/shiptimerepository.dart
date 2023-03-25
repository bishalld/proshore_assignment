import 'dart:developer';
import 'package:meroshopping_flutter/config/constants.dart';
import 'package:http/http.dart' as http;
import 'package:meroshopping_flutter/config/shared_pref.dart';
import 'package:meroshopping_flutter/model/shipping%20time/shiptimeresponse.dart';

class ShipTimeRepo {
  ///state
  Future shipTime() async {
    try {
      Uri url = Uri.parse("$ApiBaseUrl/get-time");
      final response = await http.get(
        url,
        headers: {
          "authorization": "Bearer $userToken",
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        return getTimeFromJson(response.body);
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
