// To parse this JSON data, do
//
//     final getState = getStateFromJson(jsonString);
import 'dart:convert';

GetState getStateFromJson(String str) => GetState.fromJson(json.decode(str));

String getStateToJson(GetState data) => json.encode(data.toJson());

class GetState {
  GetState({
    required this.status,
    required this.state,
  });

  bool status;
  List<State> state;

  factory GetState.fromJson(Map<String, dynamic> json) => GetState(
        status: json["status"],
        state: List<State>.from(json["state"].map((x) => State.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "state": List<dynamic>.from(state.map((x) => x.toJson())),
      };
}

class State {
  State({
    required this.id,
    required this.regionName,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String regionName;
  DateTime createdAt;
  DateTime updatedAt;

  factory State.fromJson(Map<String, dynamic> json) => State(
        id: json["id"],
        regionName: json["region_name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "region_name": regionName,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
