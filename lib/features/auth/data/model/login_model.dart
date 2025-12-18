class LoginModel {
  LoginModel({
    required this.code,
    required this.message,
    required this.data,
  });

  final int? code;
  final String? message;
  final Data? data;

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
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
