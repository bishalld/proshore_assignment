class HomeTrendingModel {
  late int id;
  late String name;
  late String image;
  late String sale;

  HomeTrendingModel({required this.id, required this.name, required this.image, required this.sale});

  HomeTrendingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    sale = json['sale'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['sale'] = this.sale;
    return data;
  }
}