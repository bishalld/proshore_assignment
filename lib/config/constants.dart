/*
this is constant pages
 */

import 'package:flutter/material.dart';

const String APP_NAME = 'mero shopping';

// color for apps
const Color PRIMARY_COLOR = Color(0xFF07ac12);
const Color ASSENT_COLOR = Color(0xFFe75f3f);

const Color CHARCOAL = Color(0xFF515151);
const Color BLACK_GREY = Color(0xff777777);
const Color SOFT_GREY = Color(0xFFaaaaaa);
const Color SOFT_BLUE = Color(0xff01aed6);
const Color MERO_SHOPPING_ICON_COLOR = Color(0xfffffeff);

const int STATUS_OK = 200;
const int STATUS_BAD_REQUEST = 400;
const int STATUS_NOT_AUTHORIZED = 403;
const int STATUS_NOT_FOUND = 404;
const int STATUS_INTERNAL_ERROR = 500;

const String ERROR_OCCURED = 'Error occured, please try again later';

const String SESSION_ID = '5f0e6bfbafe255.00218389';
const int LIMIT_PAGE = 8;

//const String GLOBAL_URL = 'https://ijtechnology.net/assets/images/api/ijshop';
//const String GLOBAL_URL = 'http://192.168.0.4/ijshop';

//const String SERVER_URL = 'https://ijtechnology.net/api_ijshop/';
//const String SERVER_URL = 'http://192.168.0.4/ijshop/api/';

const String ApiBaseUrl = "https://hamrowholesale.com/api";
const String BASE_IMAGE_URL = "https://hamrowholesale.com/images/";
const String BASE_PROFILE_IMAGE = "https://hamrowholesale.com/";

var thisYear = DateTime.now().year.toString();

class AppConfig {
  static const String ESEWA_CLIENT_ID =
      "JB0BBQ4aD0UqIThFJwAKBgAXEUkEGQUBBAwdOgABHD4DChwUAB0R";

  static const String ESEWA_SECRET_ID =
      "BhwIWQQADhIYSxILExMcAgFXFhcOBwAKBgAXEQ==";

  static String appName = "Mero Shopping";
  // app copyright
  static String copyright = "Mero Shopping " + thisYear;
  // domain name
  static const domainName = "https://www.meroshopping.com/";
}
