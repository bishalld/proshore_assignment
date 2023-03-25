// To parse this JSON data, do
//
//     final getProfileResponse = getProfileResponseFromJson(jsonString);

import 'dart:convert';

GetProfileResponse getProfileResponseFromJson(String str) =>
    GetProfileResponse.fromJson(json.decode(str));

String getProfileResponseToJson(GetProfileResponse data) =>
    json.encode(data.toJson());

class GetProfileResponse {
  GetProfileResponse({
    required this.data,
  });

  Data data;

  factory GetProfileResponse.fromJson(Map<String, dynamic> json) =>
      GetProfileResponse(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerifiedAt,
    required this.regFrom,
    required this.address,
    required this.contact,
    required this.socialId,
    required this.googleId,
    required this.photo,
    required this.dob,
    required this.gender,
    required this.zipCode,
    required this.state,
    required this.city,
    required this.country,
    required this.phone,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  dynamic name;
  dynamic email;
  dynamic emailVerifiedAt;
  dynamic regFrom;
  dynamic address;
  dynamic contact;
  dynamic socialId;
  dynamic googleId;
  dynamic photo;
  dynamic dob;
  dynamic gender;
  dynamic zipCode;
  dynamic state;
  dynamic city;
  dynamic country;
  dynamic phone;
  DateTime createdAt;
  DateTime updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        regFrom: json["reg_from"],
        address: json["address"],
        contact: json["contact"],
        socialId: json["social_id"],
        googleId: json["google_id"],
        photo: json["photo"],
        dob: json["dob"],
        gender: json["gender"],
        zipCode: json["zip_code"],
        state: json["state"],
        city: json["city"],
        country: json["country"],
        phone: json["phone"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "reg_from": regFrom,
        "address": address,
        "contact": contact,
        "social_id": socialId,
        "google_id": googleId,
        "photo": photo,
        "dob": dob,
        "gender": gender,
        "zip_code": zipCode,
        "state": state,
        "city": city,
        "country": country,
        "phone": phone,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
