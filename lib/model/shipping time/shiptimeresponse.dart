// To parse this JSON data, do
//
//     final getTime = getTimeFromJson(jsonString);
import 'dart:convert';

GetTime getTimeFromJson(String str) => GetTime.fromJson(json.decode(str));

String getTimeToJson(GetTime data) => json.encode(data.toJson());

class GetTime {
  GetTime({
    required this.success,
    required this.time,
  });

  bool success;
  List<Time> time;

  factory GetTime.fromJson(Map<String, dynamic> json) => GetTime(
        success: json["success"],
        time: List<Time>.from(json["time"].map((x) => Time.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "time": List<dynamic>.from(time.map((x) => x.toJson())),
      };
}

class Time {
  Time({
    required this.id,
    required this.timeSchedule1,
    required this.timeSchedule2,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String timeSchedule1;
  String timeSchedule2;
  int status;
  DateTime createdAt;
  DateTime updatedAt;

  factory Time.fromJson(Map<String, dynamic> json) => Time(
        id: json["id"],
        timeSchedule1: json["time_schedule1"],
        timeSchedule2: json["time_schedule2"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "time_schedule1": timeSchedule1,
        "time_schedule2": timeSchedule2,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
