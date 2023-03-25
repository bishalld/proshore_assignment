import 'dart:convert';
import 'dart:developer';
import 'package:meroshopping_flutter/config/constants.dart';
import 'package:http/http.dart' as http;
import 'package:meroshopping_flutter/model/auth/signinresponse.dart';

class SignInservice {
  Future signIn(String phone, String password) async {
    try {
      var postBody = jsonEncode({
        "contact": phone,
        "password": password,
      });
      Uri url = Uri.parse("$ApiBaseUrl/auth-login");
      final response = await http.post(
        url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        body: postBody,
      );
      print(response.body);
      if (response.statusCode == 200) {
        return signInFromJson(response.body);
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
