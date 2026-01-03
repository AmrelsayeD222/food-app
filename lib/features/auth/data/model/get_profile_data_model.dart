class GetProfileDataModel {
  final String name;
  final String email;
  final String? image;
  final String? address;
  final String? visa;

  GetProfileDataModel({
    required this.name,
    required this.email,
    this.image,
    this.address,
    this.visa,
  });

  factory GetProfileDataModel.fromJson(Map<String, dynamic> json) {
    return GetProfileDataModel(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      image: json['image'],
      address: json['address'],
      visa: json['Visa'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'image': image,
      'address': address,
      'Visa': visa,
    };
  }
}

class ProfileResponse {
  final int code;
  final String message;
  final GetProfileDataModel data;

  ProfileResponse({
    required this.code,
    required this.message,
    required this.data,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return ProfileResponse(
      code: json['code'] ?? 0,
      message: json['message'] ?? '',
      data: GetProfileDataModel.fromJson(json['data'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
      'data': data.toJson(),
    };
  }
}
