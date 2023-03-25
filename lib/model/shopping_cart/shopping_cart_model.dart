class ShoppingCartModel {
  late int id;
  late String name;
  late String image;
  late double price;
  late int qty;

  ShoppingCartModel({required this.id, required this.image, required this.name, required this.price, required this.qty});

  void setQty(int i) {
    if(i<1){
      qty = 1;
    } else {
      qty = i;
    }
  }

  ShoppingCartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    price = json['price'].toDouble();
    qty = json['qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['price'] = this.price;
    data['qty'] = this.qty;
    return data;
  }
}