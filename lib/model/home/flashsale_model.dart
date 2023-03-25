class FlashsaleModel {
  late int id;
  late String name;
  late double price;
  late String image;
  late int discount;
  late double countItem;
  late int sale;

  FlashsaleModel({required this.id, required this.name, required this.price, required this.image, required this.discount, required this.countItem, required this.sale});

  FlashsaleModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'].toDouble();
    image = json['image'];
    discount = json['discount'];
    countItem = json['countItem'].toDouble();
    sale = json['sale'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['image'] = this.image;
    data['discount'] = this.discount;
    data['countItem'] = this.countItem;
    data['sale'] = this.sale;
    return data;
  }
}