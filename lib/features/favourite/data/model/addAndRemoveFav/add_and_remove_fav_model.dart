// add_and_remove_fav_model.dart
class AddAndRemoveFavResponse {
  final int code;
  final String message;
  final dynamic data;

  AddAndRemoveFavResponse({
    required this.code,
    required this.message,
    this.data,
  });

  factory AddAndRemoveFavResponse.fromJson(Map<String, dynamic> json) {
    return AddAndRemoveFavResponse(
      code: json['code'] as int,
      message: json['message'] as String,
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
      'data': data,
    };
  }
}
