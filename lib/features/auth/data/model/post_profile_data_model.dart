class PostProfileResponse {
  final int code;
  final String message;
  final ProfileData data;

  PostProfileResponse({
    required this.code,
    required this.message,
    required this.data,
  });

  factory PostProfileResponse.fromJson(Map<String, dynamic> json) {
    return PostProfileResponse(
      code: json['code'] ?? 0,
      message: json['message'] ?? '',
      data: ProfileData.fromJson(json['data'] ?? {}),
    );
  }
}

class ProfileData {
  final String? name;
  final String? email;
  final String? address;
  final String? image;
  final String? visa;

  ProfileData({
    this.name,
    this.email,
    this.address,
    this.image,
    this.visa,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      address: json['address'] ?? '',
      image: json['image'] ?? '',
      visa: json['Visa'] ?? '',
    );
  }
}
