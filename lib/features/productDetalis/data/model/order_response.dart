class OrderResponse<T> {
  final int code;
  final String message;
  final T? data;

  OrderResponse({
    required this.code,
    required this.message,
    this.data,
  });

  factory OrderResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic json)? fromJsonT,
  ) {
    return OrderResponse<T>(
      code: json['code'],
      message: json['message'],
      data: json['data'] != null && fromJsonT != null
          ? fromJsonT(json['data'])
          : null,
    );
  }
}
