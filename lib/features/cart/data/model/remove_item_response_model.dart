class RemoveItemResponseModel {
  final int code;
  final String message;
  final dynamic data;

  RemoveItemResponseModel({
    required this.code,
    required this.message,
    this.data,
  });

  factory RemoveItemResponseModel.fromJson(Map<String, dynamic> json) {
    return RemoveItemResponseModel(
      code: json['code'] ?? 200,
      message: json['message'] ?? '',
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
