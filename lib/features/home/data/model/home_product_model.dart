class ProductResponse {
  final int code;
  final String message;
  final List<Product> data;

  ProductResponse({
    required this.code,
    required this.message,
    required this.data,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      code: json['code'] as int,
      message: json['message'] as String,
      data: (json['data'] as List)
          .map((item) => Product.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
      'data': data.map((product) => product.toJson()).toList(),
    };
  }
}

class Product {
  final int id;
  final String name;
  final String description;
  final String image;
  final String rating;
  final String price;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.rating,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
      rating: json['rating'] as String,
      price: json['price'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'rating': rating,
      'price': price,
    };
  }

  // Helper methods for type conversion
  double get ratingAsDouble => double.tryParse(rating) ?? 0.0;
  double get priceAsDouble => double.tryParse(price) ?? 0.0;
}
