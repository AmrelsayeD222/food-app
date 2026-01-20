import 'package:equatable/equatable.dart';
import 'package:foods_app/features/home/data/model/home_product_model.dart';

class GetFavResponseModel extends Equatable {
  final int code;
  final String message;
  final List<FavoriteProduct> data;

  const GetFavResponseModel({
    required this.code,
    required this.message,
    required this.data,
  });

  factory GetFavResponseModel.fromJson(Map<String, dynamic> json) {
    return GetFavResponseModel(
      code: json['code'] as int,
      message: json['message'] as String,
      data: json['data'] != null
          ? (json['data'] as List)
              .map((e) => FavoriteProduct.fromJson(e))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
      'data': data.map((e) => e.toJson()).toList(),
    };
  }

  GetFavResponseModel copyWith({
    int? code,
    String? message,
    List<FavoriteProduct>? data,
  }) {
    return GetFavResponseModel(
      code: code ?? this.code,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  @override
  List<Object?> get props => [code, message, data];
}

class FavoriteProduct extends Product with EquatableMixin {
  const FavoriteProduct({
    required super.id,
    required super.name,
    required super.description,
    required super.image,
    required super.rating,
    required super.price,
    required super.isFavorite,
  });

  factory FavoriteProduct.fromJson(Map<String, dynamic> json) {
    return FavoriteProduct(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
      rating: json['rating'] as String,
      price: json['price'] as String,
      isFavorite: json['is_favorite'] as bool,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'rating': rating,
      'price': price,
      'is_favorite': isFavorite,
    };
  }

  @override
  FavoriteProduct copyWith({
    int? id,
    String? name,
    String? description,
    String? image,
    String? rating,
    String? price,
    bool? isFavorite,
  }) {
    return FavoriteProduct(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      image: image ?? this.image,
      rating: rating ?? this.rating,
      price: price ?? this.price,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object?> get props =>
      [id, name, description, image, rating, price, isFavorite];
}
