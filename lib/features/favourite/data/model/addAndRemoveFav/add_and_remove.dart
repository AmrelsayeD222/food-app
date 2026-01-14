import 'package:equatable/equatable.dart';

class AddAndRemoveModel extends Equatable {
  final int code;
  final String message;
  final List<dynamic> data;

  const AddAndRemoveModel({
    required this.code,
    required this.message,
    required this.data,
  });

  factory AddAndRemoveModel.fromJson(Map<String, dynamic> json) {
    return AddAndRemoveModel(
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

  AddAndRemoveModel copyWith({
    int? code,
    String? message,
    List<dynamic>? data,
  }) {
    return AddAndRemoveModel(
      code: code ?? this.code,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  @override
  List<Object?> get props => [code, message, data];
}
