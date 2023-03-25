import 'dart:convert';
import 'dart:developer';

import 'package:meroshopping_flutter/config/constants.dart';
import 'package:http/http.dart' as http;
import 'package:meroshopping_flutter/config/shared_pref.dart';
import 'package:meroshopping_flutter/model/products/checkout/checkoutresponse.dart';
import 'package:meroshopping_flutter/model/products/checkout/getpaymentmethod.dart';
import 'package:meroshopping_flutter/model/products/checkout/singleproductresponse.dart';
import 'package:meroshopping_flutter/model/products/checkout/top_selling_response.dart';

class CheckOutrepo {
  Future getPaymentMethod(paymentType, tempId) async {
    try {
      var postBody = jsonEncode({
        "payment_type": paymentType,
        "temp_id": tempId,
      });
      Uri url = Uri.parse("$ApiBaseUrl/payment-type");
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $userToken',
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        body: postBody,
      );
      // print(response.body);

      if (response.statusCode == 201) {
        return getpaymentMethodFromJson(response.body);
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future checkOut(city, state, comments, amount, discount, deliverycharge,
      totalamount, cityarea, shippingtime, app) async {
    try {
      var postBody = jsonEncode({
        "city": city,
        "state": state,
        "comments": comments,
        "amount": amount,
        "discount": discount,
        "delivery_charge": deliverycharge,
        "total_amount": totalamount,
        "city_area": cityarea,
        "shipping_time": shippingtime,
        "app": app,
      });
      Uri url = Uri.parse("$ApiBaseUrl/checkout");
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
        return checkoutFromJson(response.body);
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future topSelingRepo() async {
    try {
      Uri url = Uri.parse("$ApiBaseUrl/top-selling");
      final response = await http.get(
        url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        return topSellingProductsFromJson(response.body);
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  ///single reuest for all product
  Future singleProduct(urlname) async {
    try {
      Uri url = Uri.parse("$ApiBaseUrl/product/$urlname");
      final response = await http.get(
        url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          'Authorization': 'Bearer $userToken',
        },
      );

      if (response.statusCode == 200) {
        return singleProductFromJson(response.body);
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
