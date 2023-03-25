class HomeBannerModel {
  late int id;
  late String image;

  HomeBannerModel({required this.id, required this.image});

  HomeBannerModel.fromJson(Map<String, dynamic> json) {
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