class GetProfileDataModel {
  final String? name;
  final String? email;
  final String? image;
  final String? address;
  final String? visa;

  GetProfileDataModel({
    this.name,
    this.email,
    this.image,
    this.address,
    this.visa,
  });

  factory GetProfileDataModel.fromJson(Map<String, dynamic> json) {
    return GetProfileDataModel(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      image: json['image'] ?? '',
      address: (json['address'] == null || json['address'].isEmpty)
          ? 'No address provided'
          : json['address'],
      visa: (json['Visa'] == null || json['Visa'].isEmpty)
          ? '**** **** **** ****'
          : json['address'],
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
