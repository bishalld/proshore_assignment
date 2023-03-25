class SearchModel {
  late int id;
  late String words;

  SearchModel({required this.id, required this.words});

  SearchModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    words = json['words'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['words'] = this.words;
    return data;
  }
}