class CartResponseModel {
  final int id;
  final double totalPrice;
  final List<CartItem> items;

  CartResponseModel({
    required this.id,
    required this.totalPrice,
    required this.items,
  });

  factory CartResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    if (data == null) {
      throw Exception('Cart data is null');
    }
    return CartResponseModel(
      id: data['id'],
      totalPrice: double.tryParse(data['total_price'].toString()) ?? 0.0,
      items: (data['items'] as List).map((e) => CartItem.fromJson(e)).toList(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'data': {
        'id': id,
        'total_price': totalPrice,
        'items': items.map((e) => e.toJson()).toList(),
      }
    };
  }
}

class CartItem {
  final int itemId;
  final int productId;
  final String name;
  final String image;
  final int quantity;
  final double price;
  final double spicy;
  final List<CartOption> toppings;
  final List<CartOption> sideOptions;

  CartItem({
    required this.itemId,
    required this.productId,
    required this.name,
    required this.image,
    required this.quantity,
    required this.price,
    required this.spicy,
    required this.toppings,
    required this.sideOptions,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      itemId: json['item_id'],
      productId: json['product_id'],
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      quantity: json['quantity'] ?? 0,
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      spicy: double.tryParse(json['spicy'].toString()) ?? 0.0,
      toppings: (json['toppings'] as List)
          .map((e) => CartOption.fromJson(e))
          .toList(),
      sideOptions: (json['side_options'] as List)
          .map((e) => CartOption.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'item_id': itemId,
      'product_id': productId,
      'name': name,
      'image': image,
      'quantity': quantity,
      'price': price,
      'spicy': spicy,
      'toppings': toppings.map((e) => e.toJson()).toList(),
      'side_options': sideOptions.map((e) => e.toJson()).toList(),
    };
  }
}

class CartOption {
  final int id;
  final String name;
  final String image;

  CartOption({
    required this.id,
    required this.name,
    required this.image,
  });

  factory CartOption.fromJson(Map<String, dynamic> json) {
    return CartOption(
      id: json['id'],
      name: json['name'] ?? '',
      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }
}
