import 'package:shared_preferences/shared_preferences.dart';

String? userToken = "";
String? chosenLang = "en";

class HelperClass {
  Future<void> setuserToken(String label, value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(label, value);
    pref.setInt(label, value);
  }

  Future<void> setCartItem(String label, value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt(label, value);
  }

  Future<void> getAlluserToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    userToken = pref.getString("userToken");
  }

  // Future<String> getLanguserToken() async {
  //   final SharedPreferences pref = await SharedPreferences.getInstance();
  //   chosenLang = pref.getString("chosenLang");
  //   return chosenLang ?? "";
  // }

  removeuserToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove("userToken");
    pref.remove("cartitems");
    // pref.remove("chosenLang");
    userToken = "";
    // chosenLang = "en";
  }
}
