import 'dart:developer';

import 'package:meroshopping_flutter/config/constants.dart';
import 'package:meroshopping_flutter/model/products/categories/fetch_categories_response.dart';
import 'package:http/http.dart' as http;
import 'package:meroshopping_flutter/model/products/categories/get_category_products_response.dart';
import 'package:meroshopping_flutter/model/products/categories/get_sub_categories_response.dart';
import 'package:meroshopping_flutter/model/products/categories/get_sub_category_products_response.dart';
import 'package:meroshopping_flutter/model/products/categories/get_sub_sub_category_products_response.dart';
import 'package:meroshopping_flutter/model/products/categories/get_sub_sub_category_response.dart';

class CategoryRepository {
  Future fetchCategories() async {
    try {
      Uri url = Uri.parse("$ApiBaseUrl/categories");
      final response = await http.get(
        url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        return fetchCategoriesFromJson(response.body);
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  ///getsubcategories repository
  Future getSubCategories(id) async {
    try {
      Uri url = Uri.parse("$ApiBaseUrl/subcategories/$id");
      final response = await http.get(
        url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        return getSubCategoriesFromJson(response.body);
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  ///getsubcategory repository
  Future getSubCategory(id) async {
    try {
      Uri url = Uri.parse("$ApiBaseUrl/subcategory/$id");
      final response = await http.get(
        url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        // print(response.body);
        return getSubSubCategoriesFromJson(response.body);
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  ///getsubcategory repository
  Future getSubCategoryProducts(id) async {
    try {
      Uri url = Uri.parse("$ApiBaseUrl/subcategoryProducts/$id");
      final response = await http.get(
        url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        // print(response.body);
        return getSubCategoryProductsFromJson(response.body);
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  ///getsubcategory repository
  Future getSubSubCategoryProducts(id) async {
    try {
      Uri url = Uri.parse("$ApiBaseUrl/subsubcategoryProducts/$id");
      final response = await http.get(
        url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        // print(response.body);
        return getSubSubCategoryProductsFromJson(response.body);
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  ///getsubcategory repository
  Future getCategoryProducts(id) async {
    try {
      Uri url = Uri.parse("$ApiBaseUrl/category/$id");
      final response = await http.get(
        url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        return getCategoryProductsFromJson(response.body);
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
