class ReviewModel {
  late int id;
  late String name;
  late String date;
  late double rating;
  late String review;

  ReviewModel({required this.id, required this.name, required this.date, required this.rating, required this.review});

  ReviewModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    date = json['date'];
    rating = json['rating'].toDouble();
    review = json['review'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['date'] = this.date;
    data['rating'] = this.rating;
    data['review'] = this.review;
    return data;
  }
}