import 'package:equatable/equatable.dart';

class ToggleFavModel extends Equatable {
  final int code;
  final String message;
  final List<dynamic> data;

  const ToggleFavModel({
    required this.code,
    required this.message,
    required this.data,
  });

  factory ToggleFavModel.fromJson(Map<String, dynamic> json) {
    return ToggleFavModel(
      code: json['code'] as int,
      message: json['message'] as String,
      data: json['data'] != null ? json['data'] as List<dynamic> : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
      'data': data,
    };
  }

  ToggleFavModel copyWith({
    int? code,
    String? message,
    List<dynamic>? data,
  }) {
    return ToggleFavModel(
      code: code ?? this.code,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  @override
  List<Object?> get props => [code, message, data];
}
