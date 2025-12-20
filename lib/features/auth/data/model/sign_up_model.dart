class SignUpModel {
  SignUpModel({
    required this.code,
    required this.message,
    required this.data,
  });

  final String? code;
  final String? message;
  final Data? data;

  factory SignUpModel.fromJson(Map<String, dynamic> json) {
    return SignUpModel(
      code: json["code"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }
}

class Data {
  Data({
    required this.token,
    required this.name,
    required this.email,
    required this.image,
  });

  final String? token;
  final String? name;
  final String? email;
  final String? image;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      token: json["token"],
      name: json["name"],
      email: json["email"],
      image: json["image"],
    );
  }
}
