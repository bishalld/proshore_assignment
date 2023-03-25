import 'dart:io';

import 'package:http/io_client.dart';
import 'package:meroshopping_flutter/model/auth/signinresponse.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:meroshopping_flutter/config/constants.dart';
import 'package:http/http.dart' as http;

import '../../model/auth/forgotpasswordresponse.dart';
import '../../model/auth/googlesignresponse.dart';

class SignInRepository {
  Future signIn(phone, password) async {
    try {
      var postBody = jsonEncode({
        "contact": phone,
        "password": password,
      });
      Uri url = Uri.parse("$ApiBaseUrl/auth-login");
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);

      final response = await http.post(
        url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        body: postBody,
      );
      print(response.statusCode);

      if (response.statusCode == 201) {
        return signInFromJson(response.body);
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  //forgot password

  Future forgotPassword(email) async {
    try {
      var postBody = jsonEncode({
        "email": email,
      });
      Uri url = Uri.parse("$ApiBaseUrl/forgotPassword");

      // final ioc = new HttpClient();
      // ioc.badCertificateCallback =
      //     (X509Certificate cert, String host, int port) => true;
      // final http = new IOClient(ioc);

      final response = await http.post(
        url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        body: postBody,
      );

      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        return forgotPasswordFromJson(response.body);
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
