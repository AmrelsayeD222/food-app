class UpdateProfileData {
  UpdateProfileData({
    required this.code,
    required this.message,
    required this.data,
  });

  final int? code;
  final String? message;
  final Data? data;

  factory UpdateProfileData.fromJson(Map<String, dynamic> json) {
    return UpdateProfileData(
      code: json["code"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  Data({
    required this.name,
    required this.email,
    required this.address,
    required this.image,
    required this.visa,
  });

  final String? name;
  final String? email;
  final String? address;
  final String? image;
  final dynamic visa;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      name: json["name"],
      email: json["email"],
      address: json["address"],
      image: json["image"],
      visa: json["Visa"],
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "address": address,
        "image": image,
        "Visa": visa,
      };
}
