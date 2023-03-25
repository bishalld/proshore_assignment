import 'package:meroshopping_flutter/config/shared_pref.dart';
import 'package:meroshopping_flutter/model/auth/googlesignresponse.dart';
import 'package:meroshopping_flutter/model/auth/registerresponse.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:meroshopping_flutter/config/constants.dart';
import 'package:http/http.dart' as http;

class RegisterRepository {
  Future register(name, email, password, contact, address) async {
    try {
      var postBody = jsonEncode({
        "name": name,
        "email": email,
        "password": password,
        "contact": contact,
        "address": address,
      });
      Uri url = Uri.parse("$ApiBaseUrl/register");
      final response = await http.post(
        url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        body: postBody,
      );

      if (response.statusCode == 200) {
        return registerFromJson(response.body);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future signInGmail(name, email, googleId, avatar) async {
    print(googleId);
    try {
      var postBody = jsonEncode({
        "name": name,
        "email": email,
        "google_id": googleId,
        "avatar": avatar,
        "services": "app",
      });
      Uri url = Uri.parse("$ApiBaseUrl/gmail-login");
      final response = await http.post(
        url,
        headers: {
          "Authorization": "Bearer $userToken",
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        body: postBody,
      );
      if (response.statusCode == 200) {
        print(response.body);
        return googleSignInFromJson(response.body);
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
