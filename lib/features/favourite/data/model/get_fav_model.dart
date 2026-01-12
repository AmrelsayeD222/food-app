class GetFavoritesResponse {
  final int code;
  final String message;
  final List<FavoriteProduct> data;

  GetFavoritesResponse({
    required this.code,
    required this.message,
    required this.data,
  });

  factory GetFavoritesResponse.fromJson(Map<String, dynamic> json) {
    return GetFavoritesResponse(
      code: json['code'],
      message: json['message'],
      data: (json['data'] as List)
          .map((e) => FavoriteProduct.fromJson(e))
          .toList(),
    );
  }
}

class FavoriteProduct {
  final int id;
  final String name;
  final String description;
  final String image;
  final double rating;
  final double price;
  final bool isFavorite;

  FavoriteProduct({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.rating,
    required this.price,
    required this.isFavorite,
  });

  factory FavoriteProduct.fromJson(Map<String, dynamic> json) {
    return FavoriteProduct(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      rating: (json['rating'] as num).toDouble(),
      price: (json['price'] as num).toDouble(),
      isFavorite: json['is_favorite'],
    );
  }
}
