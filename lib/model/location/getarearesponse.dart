// To parse this JSON data, do
//
//     final getArea = getAreaFromJson(jsonString);
import 'dart:convert';

GetArea getAreaFromJson(String str) => GetArea.fromJson(json.decode(str));

String getAreaToJson(GetArea data) => json.encode(data.toJson());

class GetArea {
  GetArea({
    required this.area,
  });

  List<Area> area;

  factory GetArea.fromJson(Map<String, dynamic> json) => GetArea(
        area: List<Area>.from(json["area"].map((x) => Area.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "area": List<dynamic>.from(area.map((x) => x.toJson())),
      };
}

class Area {
  Area({
    required this.id,
    required this.cityId,
    required this.areaName,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int cityId;
  String areaName;
  DateTime createdAt;
  DateTime updatedAt;

  factory Area.fromJson(Map<String, dynamic> json) => Area(
        id: json["id"],
        cityId: json["city_id"],
        areaName: json["area_name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "city_id": cityId,
        "area_name": areaName,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
