class GetProfileDataModel {
  final int? code;
  final String? message;
  final Data? data;

  GetProfileDataModel({
    this.code,
    this.message,
    this.data,
  });

  factory GetProfileDataModel.fromJson(Map<String, dynamic> json) {
    return GetProfileDataModel(
      code: json['code'],
      message: json['message'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }
}

class Data {
  final String? name;
  final String? email;
  final String? image;
  final String? address;
  final String? visa;

  Data({
    this.name,
    this.email,
    this.image,
    this.address,
    this.visa,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      name: json['name'],
      email: json['email'],
      image: json['image'],
      address: json['address'],
      visa: json['Visa'],
    );
  }
}
