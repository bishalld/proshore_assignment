// To parse this JSON data, do
//
//     final getCity = getCityFromJson(jsonString);
import 'dart:convert';

GetCity getCityFromJson(String str) => GetCity.fromJson(json.decode(str));

String getCityToJson(GetCity data) => json.encode(data.toJson());

class GetCity {
  GetCity({
    required this.city,
  });

  List<City> city;

  factory GetCity.fromJson(Map<String, dynamic> json) => GetCity(
        city: List<City>.from(json["city"].map((x) => City.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "city": List<dynamic>.from(city.map((x) => x.toJson())),
      };
}

class City {
  City({
    required this.id,
    required this.regionId,
    required this.cityName,
    required this.deliveryPrice,
    required this.insideValley,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int regionId;
  String cityName;
  int deliveryPrice;
  int insideValley;
  DateTime createdAt;
  DateTime updatedAt;

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"],
        regionId: json["region_id"],
        cityName: json["city_name"],
        deliveryPrice: json["delivery_price"],
        insideValley: json["inside_valley"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "region_id": regionId,
        "city_name": cityName,
        "delivery_price": deliveryPrice,
        "inside_valley": insideValley,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
