class AddressModel {
  late int id;
  late String title;
  late String recipientName;
  late String phoneNumber;
  late String addressLine1;
  late String addressLine2;
  late String state;
  late String postalCode;
  late bool defaultAddress;

  AddressModel({required this.id, required this.title, required this.recipientName, required this.phoneNumber, required this.addressLine1, required this.addressLine2, required this.state, required this.postalCode, required this.defaultAddress});

  AddressModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    recipientName = json['recipientName'];
    phoneNumber = json['phoneNumber'];
    addressLine1 = json['addressLine1'];
    addressLine2 = json['addressLine2'];
    state = json['state'];
    postalCode = json['postalCode'];
    defaultAddress = json['defaultAddress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['recipientName'] = this.recipientName;
    data['phoneNumber'] = this.phoneNumber;
    data['addressLine1'] = this.addressLine1;
    data['addressLine2'] = this.addressLine2;
    data['state'] = this.state;
    data['postalCode'] = this.postalCode;
    data['defaultAddress'] = this.defaultAddress;
    return data;
  }
}