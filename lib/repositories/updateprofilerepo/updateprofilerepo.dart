import 'package:meroshopping_flutter/config/constants.dart';
import 'package:http/http.dart' as http;
import 'package:meroshopping_flutter/config/shared_pref.dart';

class UpdateProfile {
  Future profileUpdate(name, photo, id) async {
    var request = http.MultipartRequest(
        'post', Uri.parse(ApiBaseUrl + "/update-profile"));
    request.fields['name'] = name;
    //request.fields['contact'] = contact;
    request.fields['user_id'] = id;
    if (photo != null)
      request.files.add(await http.MultipartFile.fromPath('photo', photo));

    request.headers.addAll({
      'Content-type': 'multipart/form-data',
      'Accept': 'application/json',
      'Authorization': 'Bearer $userToken'
    });
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return false;
    }
  }
}
