class CategoryBannerModel {
  late int id;
  late String image;

  CategoryBannerModel({required this.id, required this.image});

  CategoryBannerModel.fromJson(Map<String, dynamic> json) {
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