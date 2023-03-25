import 'dart:developer';
import 'package:meroshopping_flutter/config/constants.dart';
import 'package:http/http.dart' as http;
import 'package:meroshopping_flutter/config/shared_pref.dart';
import 'package:meroshopping_flutter/model/location/getarearesponse.dart';
import 'package:meroshopping_flutter/model/location/getcityresponse.dart';
import 'package:meroshopping_flutter/model/location/getstateresponse.dart';

class LocationRepo {
  ///state
  Future state() async {
    try {
      Uri url = Uri.parse("$ApiBaseUrl/get-state");
      final response = await http.get(
        url,
        headers: {
          "authorization": "Bearer $userToken",
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        return getStateFromJson(response.body);
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  ///city
  Future city(regionId) async {
    try {
      Uri url = Uri.parse("$ApiBaseUrl/get-city/?region_id=$regionId");
      final response = await http.get(
        url,
        headers: {
          "authorization": "Bearer $userToken",
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        return getCityFromJson(response.body);
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  ///Area
  Future area(cityId) async {
    try {
      Uri url = Uri.parse("$ApiBaseUrl/get-area?city_id=$cityId");
      final response = await http.get(
        url,
        headers: {
          "authorization": "Bearer $userToken",
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        return getAreaFromJson(response.body);
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
