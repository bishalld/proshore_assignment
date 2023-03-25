class CategoryForYouModel {
  late int id;
  late String image;

  CategoryForYouModel({required this.id, required this.image});

  CategoryForYouModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    return data;
  }
}