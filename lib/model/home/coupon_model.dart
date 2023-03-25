class CouponModel {
  late int id;
  late String name;
  late String day;
  late String term;

  CouponModel({required this.id, required this.name, required this.day, required this.term});

  CouponModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    day = json['day'];
    term = json['term'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['day'] = this.day;
    data['term'] = this.term;
    return data;
  }
}